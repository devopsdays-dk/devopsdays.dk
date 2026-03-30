---
# cspell:ignore openspace
title: "DevOpsDays Denmark"
layout: splash
permalink: /index.html
date: 2026-12-01
header:
  overlay_filter: "rgba(251, 176, 134, 0.7)"
  overlay_image: /assets/images/index/openspace.jpeg
  og_image: /assets/images/index/openspace.jpeg
  actions:
    - label: "DevOpsDays is transforming"
      url: "/stories/devops-is-broken/"
    - label: "Dive into our stories"
      url: "/stories/"      
  # caption: "The Danish DevOpsDays community at play"
excerpt: "The Danish chapter of the international DevOpsDays organization has been hosting annual 2-day conferences since 2018. Not it's time to come up with a new format"
intro: 
  - excerpt: "We are a Community of Practice. We unite technologists, developers, 
      testers, engineers, CX'ers and enthusiasts with a passion for 
      utilizing technology and digital solutions to drive meaningful 
      outcomes" 
devopsdays:
  - excerpt: "DevOpsDays is a world-wide non-profit organization - Go to visit the mother-ship web at [`devopsdays.org`](https://devopsdays.org){: target='_blank'} too"
feature_row:
  - image_path: /assets/images/index/stories-w.jpeg
    alt: "Stories"
    title: "Stories"
    excerpt: "Stories range from _general info_ to _opinionated_ posts - from the people in DevOps community"
    url: /stories/
    btn_label: "Read our stories"
    btn_class: "btn--primary align-center"
  - image_path: /assets/images/index/devops-is-broken.jpg
    alt: "DevOps is Broken"
    title: "DevOps is Broken."
    excerpt: "The planned DevOpsDays in April is canceled due, due to lack of interest to participate. Is the world of DevOps changing?"
    url: "/stories/devops-is-broken/"
    btn_label: "DevOps is Broken"
    btn_class: "btn--primary align-center"
  - image_path: /assets/images/index/slack.devopsdays.dk-w.png
    alt: "Slack"
    title: "Slack"
    excerpt: "We have our own slack, free and open to everyone. With full history preserved"
    url: "https://join.slack.com/t/devopsdays-dk/shared_invite/zt-3ccd7udqv-RV1tMfoIKO8w273HiUrQng"
    btn_label: "Slack"
    btn_class: "btn--primary align-center"
---
{% include feature_row id="intro" type="center" %}
{% include feature_row %}
{% include sponsors.liquid event="2026-cph" %}
{% include feature_row id="devopsdays" type="center" %}
