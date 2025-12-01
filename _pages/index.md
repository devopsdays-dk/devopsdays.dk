---
title: "Welcome!"
layout: splash
permalink: /
date: 2026-12-01
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/index/openspace.jpeg
  og_image: /assets/images/index/openspace.jpeg
  actions:
    - label: "See upcoming events"
      url: "/events/"
    - label: "Dive into our stories"
      url: "/stories/"      
  caption: "The Danish DevOpsDays community at play"
excerpt: "You're at the Danish DevOpsDays community site! Here you'll become part of DevOps and DevX enthusiasts and evangelists. We love to share knowledge and experience"
intro: 
  - excerpt: "We are a Community of Practice. We unite technologists, developers, 
      testers, engineers, CX'ers and enthusiasts with a passion for 
      utilizing technology and digital solutions to drive meaningful 
      outcomes" 
devopsdays:
  - excerpt: "DevOpsDays is a world-wide non-profit organization - Go to vist the mother-ship web at [`devopsdays.org`](https://devopsdays.org){: target='_blank'} too"
feature_row:
  - image_path: /assets/images/index/stories.jpeg
    alt: "Stories"
    title: "Stories"
    excerpt: "Stories range from _general info_ to _opinionated_ posts - from the people in DevOps community"
    url: /stories/
    btn_label: "🎭 Read our stories"
    btn_class: "btn--primary align-center"
  - image_path: /assets/images/index/events.jpeg
    alt: "Events"
    title: "Events"
    excerpt: "We host an annual uncoference CPH and Aarhus - and we post a lot of DevOpsy free events too."
    url: "/events/"
    btn_label: "🎪 Join our events"
    btn_class: "btn--primary align-center"
  - image_path: /assets/images/index/sponsorship.jpg
    alt: "Sponsors"
    title: "Sponsors"
    excerpt: "We offer a growing library of free hands-on self-paced tutorials. Learn what we know."
    url: "/sponsors/"
    btn_label: "🙏 Sponsors"
    btn_class: "btn--primary align-center"
---
{% include feature_row id="intro" type="center" %}
{% include feature_row %}
{% include feature_row id="devopsdays" type="center" %}
