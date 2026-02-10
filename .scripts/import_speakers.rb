#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'
require 'fileutils'

# Script to import speakers from Sessionize API
# Usage: ruby import_speakers.rb [--url URL] [--file FILE] [--event EVENT_ID]

class SessionizeImporter
  SESSIONIZE_API_URL = 'https://sessionize.com/api/v2/op1603dq/view/All'
  PROFILES_DIR = File.expand_path('../src/_profiles', __dir__)
  IMAGES_DIR = File.expand_path('../src/assets/images/profiles', __dir__)
  
  def initialize(options = {})
    @api_url = options[:url] || SESSIONIZE_API_URL
    @data_file = options[:file]
    @event_id = options[:event] || '2026-cph'
    @dry_run = options[:dry_run] || false
  end
  
  def run
    speakers = load_speakers_data
    
    puts "Found #{speakers.length} speakers to import"
    puts "Event: #{@event_id}"
    puts "Dry run: #{@dry_run}" if @dry_run
    puts ""
    
    speakers.each_with_index do |speaker, index|
      puts "[#{index + 1}/#{speakers.length}] Processing: #{speaker['fullName']}"
      import_speaker(speaker)
      puts ""
    end
    
    puts "Import complete!"
  end
  
  private
  
  def load_speakers_data
    if @data_file
      puts "Loading speakers from file: #{@data_file}"
      unless File.exist?(@data_file)
        raise "File not found: #{@data_file}"
      end
      data = JSON.parse(File.read(@data_file))
      
      # Handle different data formats
      speakers = extract_speakers_from_data(data)
      
      # Deduplicate speakers by ID
      unique_speakers = {}
      speakers.each do |speaker|
        unique_speakers[speaker['id']] = speaker
      end
      
      unique_speakers.values
    else
      puts "Fetching speakers from API: #{@api_url}"
      data = fetch_from_api
      speakers = extract_speakers_from_data(data)
      
      # Deduplicate speakers by ID
      unique_speakers = {}
      speakers.each do |speaker|
        unique_speakers[speaker['id']] = speaker
      end
      
      unique_speakers.values
    end
  end
  
  def extract_speakers_from_data(data)
    if data.is_a?(Array)
      # Could be array of speakers or array of sessions with speakers
      if data.first && data.first['speakers']
        # Array of sessions with nested speakers
        speakers = []
        data.each do |session|
          speakers.concat(session['speakers']) if session['speakers']
        end
        speakers
      else
        # Direct array of speakers
        data
      end
    elsif data.is_a?(Hash) && data['speakers']
      # Object with speakers key
      data['speakers']
    else
      raise "Unexpected data format. Expected array of speakers or sessions with speakers"
    end
  end
  
  def fetch_from_api
    uri = URI.parse(@api_url)
    response = Net::HTTP.get_response(uri)
    
    unless response.is_a?(Net::HTTPSuccess)
      raise "Failed to fetch data from API: #{response.code} #{response.message}"
    end
    
    JSON.parse(response.body)
  end
  
  def import_speaker(speaker)
    slug = generate_slug(speaker['firstName'], speaker['lastName'])
    puts "  Slug: #{slug}"
    
    # Download profile picture
    image_filename = download_profile_picture(speaker['profilePicture'], slug)
    puts "  Image: #{image_filename}"
    
    # Create profile markdown
    create_profile_markdown(speaker, slug, image_filename)
    puts "  Profile created: src/_profiles/#{slug}.md"
  end
  
  def generate_slug(first_name, last_name)
    # Combine first and last name with space
    full_name = "#{first_name} #{last_name}"
    
    # Convert to lowercase
    slug = full_name.downcase
    
    # Transliterate common non-ASCII characters
    slug = transliterate(slug)
    
    # Replace spaces with hyphens
    slug = slug.gsub(/\s+/, '-')
    
    # Remove any characters that are not a-z, 0-9, or hyphen
    slug = slug.gsub(/[^a-z0-9-]/, '')
    
    # Remove consecutive hyphens
    slug = slug.gsub(/-+/, '-')
    
    # Remove leading/trailing hyphens
    slug = slug.gsub(/^-+|-+$/, '')
    
    slug
  end
  
  def transliterate(text)
    # Basic transliteration map for common European characters
    transliterations = {
      'á' => 'a', 'à' => 'a', 'â' => 'a', 'ä' => 'a', 'ã' => 'a', 'å' => 'a', 'æ' => 'ae',
      'é' => 'e', 'è' => 'e', 'ê' => 'e', 'ë' => 'e',
      'í' => 'i', 'ì' => 'i', 'î' => 'i', 'ï' => 'i',
      'ó' => 'o', 'ò' => 'o', 'ô' => 'o', 'ö' => 'o', 'õ' => 'o', 'ø' => 'o',
      'ú' => 'u', 'ù' => 'u', 'û' => 'u', 'ü' => 'u',
      'ý' => 'y', 'ÿ' => 'y',
      'ñ' => 'n',
      'ç' => 'c',
      'ß' => 'ss',
      'þ' => 'th',
      'ð' => 'd'
    }
    
    text.chars.map { |char| transliterations[char] || char }.join
  end
  
  def download_profile_picture(url, slug)
    return nil if url.nil? || url.empty?
    
    # Determine file extension from URL
    uri = URI.parse(url)
    ext = File.extname(uri.path)
    ext = '.jpg' if ext.empty?
    
    # Use .webp as default for downloaded images (consistent with existing profiles)
    filename = "#{slug}.webp"
    filepath = File.join(IMAGES_DIR, filename)
    
    if @dry_run
      puts "  [DRY RUN] Would download: #{url} -> #{filepath}"
      return filename
    end
    
    # Download the image
    begin
      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        puts "  WARNING: Failed to download image: #{response.code}"
        return nil
      end
      
      File.write(filepath, response.body, mode: 'wb')
      filename
    rescue StandardError => e
      puts "  WARNING: Error downloading image: #{e.message}"
      nil
    end
  end
  
  def create_profile_markdown(speaker, slug, image_filename)
    filepath = File.join(PROFILES_DIR, "#{slug}.md")
    
    if @dry_run
      puts "  [DRY RUN] Would create: #{filepath}"
      return
    end
    
    # Extract social links
    social = extract_social_links(speaker['links'])
    
    # Build frontmatter
    frontmatter = {
      'name' => speaker['fullName'],
      'headline' => speaker['tagLine'] || '',
      'image' => image_filename || '',
      'company' => '',
      'email' => '',
      'cell' => '',
      'pronoun' => '',
      'location' => '',
      'social' => social,
      'roles' => ['speaker'],
      'events' => [@event_id]
    }
    
    # Add sessionize data if available
    if speaker['id'] || speaker['sessions']
      frontmatter['sessionize'] = {}
      frontmatter['sessionize']['id'] = speaker['id'] if speaker['id']
      frontmatter['sessionize']['sessions'] = speaker['sessions'] if speaker['sessions']
    end
    
    # Write the file
    File.open(filepath, 'w') do |f|
      f.puts '---'
      f.puts format_frontmatter(frontmatter)
      f.puts '---'
      f.puts ''
      f.puts speaker['bio'] if speaker['bio']
    end
  end
  
  def extract_social_links(links)
    return {} if links.nil? || links.empty?
    
    social = {}
    
    links.each do |link|
      url = link['url']
      next if url.nil? || url.empty?
      
      case link['linkType']
      when 'Twitter'
        # Extract username from Twitter/X URL
        if url =~ %r{(?:twitter\.com|x\.com)/([^/?]+)}
          social['x'] = $1
        end
      when 'LinkedIn'
        # Extract username/path from LinkedIn URL
        if url =~ %r{linkedin\.com/in/([^/?]+)}
          social['linkedin'] = $1
        end
      when 'Blog'
        social['website'] = url
      when 'Company_Website'
        # Store company website separately or in website if website is empty
        social['website'] ||= url
      when 'Sessionize'
        social['sessionize'] = url
      when 'GitHub'
        if url =~ %r{github\.com/([^/?]+)}
          social['github'] = $1
        end
      end
    end
    
    social
  end
  
  def format_frontmatter(data, indent = 0)
    lines = []
    indent_str = '  ' * indent
    
    data.each do |key, value|
      if value.nil? || (value.is_a?(String) && value.empty?)
        lines << "#{indent_str}#{key}: "
      elsif value.is_a?(Hash)
        lines << "#{indent_str}#{key}:"
        lines << format_frontmatter(value, indent + 1)
      elsif value.is_a?(Array)
        lines << "#{indent_str}#{key}:"
        value.each do |item|
          if item.is_a?(Hash)
            lines << format_frontmatter(item, indent + 1)
          else
            lines << "#{indent_str}  - #{item}"
          end
        end
      else
        # Quote strings if they contain special characters  
        if value.is_a?(String) && value.match?(/[:#\{\}\[\]!|>&*%@]/)
          lines << "#{indent_str}#{key}: \"#{value.gsub('"', '\"')}\""
        else
          lines << "#{indent_str}#{key}: #{value}"
        end
      end
    end
    
    lines.join("\n")
  end
end

# Parse command line arguments
options = {}
args = ARGV.dup

while args.any?
  arg = args.shift
  case arg
  when '--url'
    options[:url] = args.shift
  when '--file', '-f'
    options[:file] = args.shift
  when '--event', '-e'
    options[:event] = args.shift
  when '--dry-run'
    options[:dry_run] = true
  when '--help', '-h'
    puts <<~HELP
      Usage: ruby import_speakers.rb [OPTIONS]
      
      Options:
        --url URL         Sessionize API URL (default: #{SessionizeImporter::SESSIONIZE_API_URL})
        --file FILE       Load data from local JSON file instead of API
        --event EVENT     Event ID to assign to speakers (default: 2026-cph)
        --dry-run         Show what would be done without making changes
        --help            Show this help message
    HELP
    exit 0
  else
    puts "Unknown option: #{arg}"
    exit 1
  end
end

# Run the importer
importer = SessionizeImporter.new(options)
importer.run
