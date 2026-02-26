---
# cspell:ignore openspace
title: "Welcome!"
layout: splash
permalink: /home/
date: 2026-12-01
header:
  overlay_filter: "rgba(251, 176, 134, 0.7)"
  overlay_image: /assets/images/index/openspace.jpeg
  og_image: /assets/images/index/openspace.jpeg
  actions:
    - label: "See upcoming events"
      url: "/events/"
    - label: "Dive into our stories"
      url: "/stories/"      
  caption: "The Danish DevOpsDays community at play"
excerpt: "You're at the Danish DevOpsDays community site! Join DevOps and DevX enthusiasts and devotees. We love to share knowledge and experience"
intro: 
  - excerpt: "We are a Community of Practice. We unite technologists, developers, 
      testers, engineers, CX'ers and enthusiasts with a passion for 
      utilizing technology and digital solutions to drive meaningful 
      outcomes" 
devopsdays:
  - excerpt: "DevOpsDays is a world-wide non-profit organization - Go to visit the mother-ship web at [`devopsdays.org`](https://devopsdays.org){: target='_blank'} too"
feature_row:
  - image_path: /assets/images/index/stories.jpeg
    alt: "Stories"
    title: "Stories"
    excerpt: "Stories range from _general info_ to _opinionated_ posts - from the people in DevOps community"
    url: /stories/
    btn_label: "Read our stories"
    btn_class: "btn--primary align-center"
  - image_path: /assets/images/index/events.jpeg
    alt: "Next up..."
    title: "Next up..."
    excerpt: "Next event is DevOpsDays in Copenhagen in April. Registration is open and CFP is still open"
    url: "/events/2026-cph/"
    btn_label: "Copenhagen 2026"
    btn_class: "btn--primary align-center"
  - image_path: /assets/images/index/slack.devopsdays.dk.png
    alt: "Slack"
    title: "Slack"
    excerpt: "We have our own slack, free and open to everyone. With full history preserved"
    url: "https://join.slack.com/t/devopsdays-dk/shared_invite/zt-3ccd7udqv-RV1tMfoIKO8w273HiUrQng"
    btn_label: "Slack"
    btn_class: "btn--primary align-center"
sponsors_heading:
  - excerpt: "## Sponsors for the upcoming event"
---
{% include feature_row id="intro" type="center" %}
{% include feature_row %}
{% include feature_row id="sponsors_heading" type="center" %}
{% include sponsors event="2026-cph" %}
{% include feature_row id="devopsdays" type="center" %}
