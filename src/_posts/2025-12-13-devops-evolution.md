---
title:  DevOps Evolution
author: Lars Kruse
author_profile: true
excerpt: "What is DevOps — we have discussed this since the #DevOps hashtag was first used, but maybe we don't need to define it; just reflect on what it embraces"
toc: true
toc_sticky: true
search: true
header:
  teaser: /assets/images/posts/evolution/devops-evolution.jpg
tags:
  - DevOps
# cspell:ignore devopsy
---

{% responsive_image
  path: "assets/images/posts/evolution/devops-evolution.jpg"
  alt: "DevOps Evolution"
  caption: "What is DevOps — we have discussed this since the #DevOps hashtag was first used, but maybe we don't need to define it; just reflect on what it embraces"
  class: "center full top"
%}

## DevOps Evolution

_"What is DevOps?"_ — we have discussed this since the concept hatched in ~2008, but maybe we don't need to actually define it; just reflect on what DevOps encompasses and embrace it all in the our _Community of Contemporary DevOps_
{: .kicker}

I set out to write this post with the intent of guiding [potential speakers](../become-a-speaker) at our conferences in the commonly asked question:

>_"Is my topic fit for the DevOps Conference?"_

The post still serves that purpose but it also double a good read for _participants_ at our conferences in getting a feel for what the content of our conferences could entail.

It even triples as an invite to _practitioners_ of everyday "dev" and "ops" chores to see that their skills are indeed _DevOpsy_ and unite with peer, masters and apprentices under our DevOps banner.

[Join our slack](https://slack.devopsdays.dk){: .btn .btn--success target="_blank" title="Open to all"}

## The DevOps Timeline

DevOps was _invented_ as Twitter hashtag `#DevOps` for a conference on _Agile Infrastructure_ in 2009 in Ghent. Already the year after, the same recurring conference was branded as **DevOpsDays**. And here we are!

But hey: _"isn't agile dead?"_ you might ask. And if that is the case isn't DevOps dead too then?

Well; _"NO! — no one died"_. But it's right to question if DevOps is _the same_ as when it was hatched in 2008 — it's not. DevOps has evolved a lot and you have a standing invitation to join the community and both contribute and challenge the what DevOps really is.

### 2008 – 2015 Branching Strategies and Automation Pipelines

Paul Duvall published a book "Continuos Integration" in 2007 and Humble and Farley published "Continuous Delivery" in 2010 The were both in A&W's "Marting Fowler Signature Series". And while DevOps doesn't have an actual widely accepted manifest like the Agile paradigm have, these two books are the closest we come to a common ground the DevOps paradigm. Due to the endorsement from Martin Fowler one of the Agile Manifesto's Founding Fathers and a widely recognized Agile movement celebrity the tie between Agile and DevOps was undeniable — especially in the early years.

"CI/CD" became a synonym with DevOps. The Jenkins CI server; Kohsuke Kawaguchi's masterpiece of a configurable and expandible Open Source build automaton platform was the most novel concept introduced to Software Development since the introduction of Object Oriented programming. Jenkins CI was forked off of Hudson in 2011. It was a story of David fighting Goliath (Kohsuke vs Oracle). _Everyone_ should have Jenkins Ci server.

### 2015 — 2020 Containerization and NUM3ER5 — The split

Docker was release in 2013, an astronomical evolution step in IT by itself. Cloud Native Foundation and Kubernetes were co-released in 2015 and it's fair to say that the World hasn't been the same since. The DevOps community was the first to embraces containerization as _unconditionally good_.

DevOps ❤️ Containers. Concepts like _Configuration as Code_ and _Infrastructure as Code_ became hot topics. Tools like Terraform and Helm emerged to make infrastructure programmable and reproducible, transforming how operations teams provisioned and managed cloud resources at scale.

Observability matured alongside containerization. Prometheus and the ELK stack made it possible to see into distributed systems in ways we'd never imagined. And Google's Site Reliability Engineering (SRE) handbook in 2016 introduced a distinct philosophy that automation and data-driven operations are the path forward. DevSecOps also emerged as a trend, advocating that security couldn't be bolted on at the end—it had to be woven through the entire delivery pipeline.

In the early days on the DevOps movement it attracted more "devs" and less "ops". Now with the containerization and orchestration perspective, DevOps built a home in the Cloud and all the "ops" could see themselves as first class citizens there. Yet as cloud costs spiraled, FinOps emerged around 2019 as a counterbalance —  reminding us that fast deployment means nothing if you're hemorrhaging money on idle resources.

In the early days of DevOps the sentiment was that "DevOps is a culture — breaking down silos" Gene Kim was an important avantgarde for this perspective. It was also in 2015 Gene Kim release the novel "The Phoenix Projects" which won wide recognition as the "DevOps New Testament". We would proudly parade doctrines like "DevOps is Culture" and "DevOps is not a team — It's a way of working"

In 2018 Kim joined forces with an old DevOps celeb; Jez Humble and a new protégé Nicole Forsgren — a number-crusher magician and they jointly release a new book "Accelerate" in 2018 explaining the rationale behind the _DevOps Research and Assessment institute_ (DORA) report which they had released annually since 2014.

DORA offered a clean _lean_ perspective on DevOps and Continuous Delivery. Focusing on lead-times, value stream optimization, build-quality in, Throughput and Stability advocating that we should analyze and optimize our workflows based on actual NUM3ER5 pulled from the system.

During this period DevOps as a concept formed two new distinct schools - on top of the already established "DevOps is CI/CD" and "DevOps is Culture" ones. We had arrived at a somewhat ambiguous point:

- "DevOps is CI/CD"
- "DevOps is Culture"
- "DevOps is Programmable and Immutable Infrastructure"
- "DevOps is lean software development stream optimization"

A split was emerging. KubeCon and Cloud Native Foundation — although considered inherently _good_ also offered a cleaner alternative home for all the "ops" and a good portion of them moved out of the house and never looked back.

The DevOps movement was once again in jeopardy of being a _mostly "devs"_ community.

### 2020 — 2023 Serverless, Full-stack and DevX

Firebase (Google), Supabase (PostgreSQL), Cloud Functions(Azure), Lambda function (Amazon) all matured quickly in the new containerized world and soon offered a compelling NoOps alternative to _servers_ without the need to become a Docker expert on the side. Embraced by millennials and zoomers who — in the mean time — had been thought in uni that full-stack=MERN[^mern] stack.

[^mern]: MERN: MongoDB - Express - React - Node. A contemporary alternative to the LAMP stack (Linux - Apache - MySql - PHP)

GitHub release CodeSpaces in 2020, a web based NoOps extension based on devcontainers (2019) also natively supported by VS Code, and myriads of other Open Source IDE spin-offs. Containers were no longer exclusive to _cloud_ and _infrastructure_ nerds. They regained relevance to _all_ developers in an emerging Developer Experience (DevX) trend. Where event the Development environment, the IDE and the _workflows_ were containerized too. The shift to remote-first work — obviously driven forcefully by the COVID pandemic — accelerated this adoption. Teams distributed across geographies embraced containerized development environments as a way to ensure consistency and reduce friction.

Nowadays _every_ develop can hack a Docker file, setup their own declarative pipeline in yaml and deploy to some abstraction of an _infrastructure_ in the cloud.

The DevOps proverb "You Build It You Run It" is now widely embraced even by the new generations, although not entirely the way the boomers and Gen-X that inhabited the Devops world had anticipated. The apprentice surpass the master. But hey, isn't that what all _true_ masters unselfishly hope to aspire in there apprentices?

The fresh blood and young minds were welcomed into the DevOps community.

DevOps isn't dead — it's simply the new normal.

### 2024 — ... I Dare You — Say 'AI' One More Time

GitHub released Co-Pilot for technical preview in February 2021 and it was made publicly available for subscriptions in June 2022. Already in 2024 both DORA, Stack Exchange and GitClear could reveal convincing statistical proof that AI is jeopardizing the overall quality of mankind's joint codebase at a speed that no one could have predicted.

At the same time AI, Vibe Coding and Prompt Engineering is — apparently — enabling DevOps core values like _fast feedback loops with end-users_ and _breaking down silos_, by allowing Citizen Developers and self-made hackers to produce — apparently — ruining code at a pace that also no one could have predicted.

Developers cry out – "code quality is as risk" and while the do, the LLM's are improving at a speed that exceed even the most farfetched Science Fiction.

The "Terminator Trilogy" dystopias may turn out to be unambitious compared to real-life.

The DevOps community keep focus on Developer Experience and Continuous Delivery and DevOps core values like _maintainability_, _security_, _reliability_ are up for being redefined in the AI era.

We take it on our shoulders to do that. We obviously don't know what will hit us next, but we know that we will stay united.

## Contemporary DevOps buzzes

Below is a glossary of some of the terms, tools, techniques and concepts that are encompassed in Contemporary DevOps
{: .kicker}

Automation / Autonomation

: Process of automating repetitive tasks to reduce manual effort and human error. Autonomation (automation + autonomy) extends this by enabling systems to make intelligent decisions and self-heal without human intervention.

Automated Testing

: Practice of writing and running tests programmatically — unit, integration, end-to-end—to validate application behavior continuously, reducing manual testing effort and catching regressions quickly.

ChatOps

: Practice of executing operational tasks and automations through chat interfaces and bots, bringing visibility to operations work, enabling collaboration, and reducing context-switching between tools.

Citizen Development

: Empowerment of non-traditional developers to build applications and automations using low-code/no-code platforms and AI assistance, democratizing software creation across the organization.

Configuration as Code

: Infrastructure and application configuration expressed as versioned code rather than manual setup, enabling reproducibility, auditability, and integration into version control and deployment pipelines.

Configuration Management

: Practice of systematically tracking, controlling, and applying changes to system configurations across infrastructure and applications, ensuring consistency, auditability, and repeatability in environments.

Containerization

: Lightweight virtualization technology that packages applications with their dependencies into isolated, portable units. Docker revolutionized this space by making containers accessible to mainstream development teams.

Continuos Integration

: A set of branching strategies and work disciplines that advocates and encourages teams to keep the main integration branch  _always shippable_ — sometimes also referred to as Trunk-based development.

Continuous Delivery

: A software development practice that lends from lean principles and advocates that quality should be controlled at the source and automated one-piece flows should carry the changes all the way to actual deployment in production.

Culture and Silos

: DevOps principle that technical practices alone cannot succeed without cultural shifts breaking down barriers between development and operations, enabling collaboration and shared ownership.

Dashboards / Visualizations

: Real-time displays of system metrics, application performance, and business KPIs that make complex data accessible at a glance, enabling quick decision-making and incident response.

Declarative Pipelines

: CI/CD approach where pipeline configuration is expressed declaratively—defining desired state rather than imperative steps—enabling version control, reproducibility, and easier maintenance of build and deployment workflows.

Developer Experience (DevX)

: Holistic approach to improving developers' satisfaction and productivity through better tooling, workflows, documentation, and environments—recognizing that developer satisfaction drives software quality.

Developer Platforms & Marketplaces

: Centralized ecosystems (e.g. Backstage, GitHub Marketplace, artifact registries) that discover, share, and manage DevOps tooling, templates, and extensions — enabling knowledge sharing and accelerating adoption of community practices.

DevContainers

: Development containers specification and tooling that standardize local development environments in containers, ensuring consistency across team members and with CI/CD pipelines.

DevSecOps

: Integrated practice embedding security throughout the entire software delivery pipeline rather than as a bolted-on afterthought, shifting security left and making it everyone's responsibility.

DORA Metrics

: Four key metrics—deployment frequency, lead time for changes, mean time to recovery, and change failure rate—used to measure software delivery performance and organizational effectiveness.

Emulators / Digital Twins

: Virtual replicas of physical systems or infrastructure that simulate real-world behavior, enabling teams to test, validate, and optimize solutions in safe environments before production deployment.

Extensions / Plugins

: Ecosystem practice of extending existing platforms — e.g. GitHub Actions, VS Code extensions, Kubernetes operators, Terraform providers — allowing practitioners to contribute reusable solutions and amplify DevOps practices across communities.

FinOps

: Financial operations discipline for cloud cost management, treating infrastructure spending as a shared responsibility between engineering, finance, and operations to optimize cloud investments.

FlowTech

: Emerging discipline focused on optimizing developer workflows and productivity by removing friction points, integrating tools, and automating context-switching — extending DevX principles across the entire development lifecycle.

GitOps

: Operational model using Git as the single source of truth for infrastructure and application configuration, automating deployments when code changes are merged, combining version control with continuous delivery.

Helm

: Package manager for Kubernetes that simplifies deploying and managing complex applications by bundling manifests, configurations, and dependencies into reusable charts.

IDE Integrated AI Agents

: AI-powered tools integrated into development environments that generate code suggestions, assist with problem-solving, and augment developer productivity in real-time. Represent both the democratization of coding and emerging quality concerns in the AI era.

Infrastructure as Code (IaC)

: Practice of managing and provisioning computing infrastructure through machine-readable code rather than physical hardware configuration or interactive tools, enabling version control and automation.

Internal Developer Platform (IDP)

: Self-service platform built by platform engineering teams that abstracts infrastructure complexity, allowing developers to deploy, scale, and manage applications without deep operational knowledge.

Kubernetes

: Open-source orchestration platform that automates deployment, scaling, and management of containerized applications across clusters, becoming the de facto standard for container orchestration.

Lean Software Development

: Software engineering discipline rooted in lean manufacturing principles—emphasizing waste elimination, value stream optimization, fast feedback loops, and continuous improvement. Core philosophy underlying DevOps practices and metrics like DORA.

Observability

: Practice of understanding complex system behavior through comprehensive data collection—logs, metrics, traces—enabling teams to ask arbitrary questions about system state and quickly diagnose issues.

Platform Engineering

: Discipline focused on building internal developer platforms that abstract infrastructure complexity, enabling development teams to self-serve while maintaining governance and security.

Prometheus

: Open-source monitoring and alerting toolkit that scrapes time-series metrics from applications and infrastructure, providing a flexible foundation for observability in cloud-native environments.

Prompt Engineering

: Skill of crafting effective instructions, RAGs and queries for AI language models to generate useful code, documentation, and solutions—increasingly important as AI tools become integral to DevOps workflows.

Serverless / FaaS

: Computing model where cloud providers manage infrastructure, allowing developers to deploy functions or code snippets that scale automatically without managing servers or containers.

Site Reliability Engineering (SRE)

: Google-formulated discipline that applies software engineering approaches to infrastructure and operations problems, emphasizing automation, data-driven decisions, and error budgets for reliability.

Social Coding

: Collaborative development culture enabled by platforms like GitHub, emphasizing code review, transparent collaboration, knowledge sharing, and distributed contribution — a cultural cornerstone of modern DevOps.

Static Code Analysis

: Automated examination of source code without executing it, detecting potential bugs, security flaws, and code quality issues early in development, shifting quality checks left in the pipeline.

Terraform

: Infrastructure as Code tool that enables declarative definition and management of cloud resources across multiple providers, treating infrastructure provisioning as reproducible code.

Tooling & Scripting

: DevOps practice of building, maintaining, and sharing custom utilities, scripts, and helper tools that operationalize workflows, reduce manual effort, and enable team-specific optimizations and automation.

Vulnerability Scanning

: Automated process that analyzes code, dependencies, and running systems to identify known security vulnerabilities, enabling proactive remediation before exploits reach production environments.

You Build It, You Run It

: DevOps philosophy that teams owning code also own its operational aspects and incident response, fostering accountability and enabling faster feedback loops and improvements.

---
