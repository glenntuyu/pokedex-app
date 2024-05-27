# Pokédex App

Pokédex App is an application developed using Flutter that provides a Pokemon Database App designed using Clean Architecture principles. It contains features such as home screen with infinite scrolling showing the Pokédex and Pokemon Detail.

## Features

1. **Home Page**
   - Displays list of Pokemon. (Infinite Scroll)

2. **Pokemon Details**
   - Provides detailed information about selected Pokemon.

## Tech Stacks

1. **Clean Architecture**
Create a separation of concern between layers into presentation, domain, and data for a modular and scalable codebase.
   - **Presentation Layer**: Contains UI components and presentation logic.
   - **Domain Layer**: Defines use cases and business logic independent of UI.
   - **Data Layer**: Manages data sources, repositories, and external services.

2. **Bloc**
   - A state management that helps to separate presentation layer from business logic.

3. **Isolate for JSON Parsing**
   - Efficiently parses JSON data using isolates for better performance.

## Open API
Pokedex App uses the PokeAPI ("https://pokeapi.co/")

## App preview
![Home](preview/home.jpeg) 
![Pokemon Info - About](preview/detail_about.jpeg) 
![Pokemon Info - Evolution](preview/detail_evolution.jpeg) 
![Pokemon Info - Stats](preview/detail_stats.jpeg) 
![Pokemon Info - Stats (Expanded)](preview/detail_expanded.jpeg) 
![Pokemon Info - Home Dark Mode](preview/home_dark.jpeg)
![Pokemon Info - About Dark Mode](preview/detail_about_dark.jpeg) 
![Pokemon Info - Evolution Dark Mode](preview/detail_evolution_dark.jpeg) 
![Pokemon Info - Stats Dark Mode](preview/detail_stats_dark.jpeg) 
![Pokemon Info - Stats (Expanded) Dark Mode](preview/detail_expanded_dark.jpeg) 