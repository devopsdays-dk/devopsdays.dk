document.addEventListener('DOMContentLoaded', function() {
  const filterBtns = document.querySelectorAll('.filter-btn');
  const speakerCards = document.querySelectorAll('.speaker-card');
  const mainElement = document.getElementById('main');
  
  // Get event map from data attribute
  let eventMap = {};
  if (mainElement && mainElement.dataset.eventMap) {
    try {
      eventMap = JSON.parse(mainElement.dataset.eventMap);
    } catch (e) {
      console.error('Error parsing event map:', e);
    }
  }
  
  // Parse URL query parameters on load
  function parseParams() {
    const params = new URLSearchParams(window.location.search);
    const presetRole = mainElement.dataset.filterRole;
    return {
      role: params.get('role') || presetRole || '',
      event: params.get('event') || ''
    };
  }

  // Update URL with query parameters
  function updateParams(role, event) {
    const params = new URLSearchParams();
    if (role) params.set('role', role);
    if (event) params.set('event', event);
    
    const queryString = params.toString();
    const newUrl = queryString ? `?${queryString}` : window.location.pathname;
    window.history.replaceState({}, '', newUrl);
  }

  // Update button states based on filters
  function updateButtonStates(role, event) {
    filterBtns.forEach(btn => {
      const btnType = btn.dataset.filter;
      const btnValue = btn.dataset.value;
      
      if (btnType === 'role') {
        btn.classList.toggle('active', btnValue === role);
      } else if (btnType === 'event') {
        btn.classList.toggle('active', btnValue === event);
      }
    });
    
    // Update the event display subtitle
    const filterDisplay = document.getElementById('active-filter-display');
    if (filterDisplay) {
      if (event) {
        const eventData = eventMap[event];
        const eventTitle = (eventData && eventData.title) ? eventData.title : event;
        filterDisplay.innerHTML = '<p class="event-subtitle">' + eventTitle + '</p>';
      } else {
        filterDisplay.innerHTML = '';
      }
    }
  }

  // Filter speakers based on current query parameters
  function applyFilters() {
    const filters = parseParams();
    updateButtonStates(filters.role, filters.event);
    
    speakerCards.forEach(card => {
      const roles = card.dataset.roles ? card.dataset.roles.split(',') : [];
      const events = card.dataset.events ? card.dataset.events.split(',') : [];

      const matchesRole = !filters.role || roles.includes(filters.role);
      const matchesEvent = !filters.event || events.includes(filters.event);

      if (matchesRole && matchesEvent) {
        card.style.display = '';
        card.classList.add('fade-in');
      } else {
        card.style.display = 'none';
        card.classList.remove('fade-in');
      }
    });
  }

  // Button click handler
  filterBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      const filters = parseParams();
      const filterType = this.dataset.filter;
      const filterValue = this.dataset.value;

      if (filterType === 'role') {
        filters.role = filterValue;
      } else if (filterType === 'event') {
        filters.event = filterValue;
      }

      updateParams(filters.role, filters.event);
      applyFilters();
    });
  });

  // Listen for popstate (browser back/forward)
  window.addEventListener('popstate', applyFilters);

  // Apply filters on initial load
  applyFilters();
});
