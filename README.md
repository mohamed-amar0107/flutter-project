# E-Commerce Flutter Application  
## Project Briefing and Documentation

## Executive Summary
This document synthesizes the development and technical framework of the **ecommflutter1** project, a mobile e-commerce application developed using the **Flutter** framework. Designed as a functional prototype for the **Università degli Studi di Urbino Carlo Bo**, the application integrates real-world data from the **FakeStoreAPI** and implements advanced features such as local data persistence, state management via the **Provider** package, and multi-language support.

The project successfully fulfills the academic requirements (**V1–V7**) by providing a responsive user interface, secure authentication flows, and a localized shopping experience.

---

## Student Information
- **Name:** Mohamed Ammar  
- **University:** Università degli Studi di Urbino Carlo Bo, Italy  
- **Matricola:** 345599  
- **Academic Email:** m.ammar1@campus.uniurb.it  

---

## 1. Project Overview

**Project Title:** `ecommflutter1`  

**Project Idea:**  
The objective of this project is to develop a comprehensive **E-Commerce mobile application** that allows users to browse products, manage a shopping cart, and customize their viewing experience. The app fetches real-time data from an external Web API while maintaining a local database for cart management.

### Key Features
- **Product Browsing:**  
  All users (authenticated or guests) can view available products categorized by type (e.g., men’s clothing, jewelry).
- **User Authentication:**  
  Secure login and registration systems powered by the **FakeStoreAPI**.
- **Shopping Cart:**  
  Authenticated users can add items to a cart, adjust quantities, and remove items.
- **Local Persistence:**  
  The shopping cart is stored locally to ensure data availability across sessions.
- **Personalization:**  
  Users can switch between **Light/Dark themes** and change the app language (**English / French**).
- **User Profile:**  
  Access to account details such as name, email, and user role.

---

## 2. User Experience (UX)

The application follows a clear and intuitive navigation flow:

1. **Splash Screen**  
   A brief 1.5-second entry screen.
2. **Home Screen (Product Feed)**  
   The main landing page displaying available products.
3. **Authentication**  
   Access to *Connexion (Login)* and *Register* screens for personalized features.
4. **Cart Management**  
   A dedicated screen to review items, update quantities, and calculate totals.
5. **Settings**  
   Allows users to modify theme preferences and language settings.

## Application Screenshots

### Login Screen
<img src="assets/signin.jfif" alt="Login Screen" width="300"/>

### Product Catalog
<img src="assets/product.jfif" alt="Product Catalog" width="300"/>

### Shopping Cart
<img src="assets/carousel.jfif" alt="Shopping Cart" width="300"/>

### Settings
<img src="assets/settings.jfif" alt="Settings" width="300"/>

---



## 3. Technical Implementation

### Core Technologies and Packages

| Package / Technique        | Purpose |
|---------------------------|---------|
| Flutter Framework         | Cross-platform mobile development (Android focus) |
| Provider                 | State management for Authentication, Theme, and Language |
| FakeStoreAPI             | External REST API for products and user authentication |
| SQLite                   | Local database for shopping cart persistence |
| Flutter Localizations    | English and French language support |
| Material Design          | Modern UI components and styling |

### API Endpoints
- **Products:** `https://fakestoreapi.com/products`  
- **Users / Auth:** `https://fakestoreapi.com/users`

### Technical Choices
- **State Management:**  
  `MultiProvider` is implemented in `main.dart` to manage global states (Authentication, Theme, Language) efficiently and ensure real-time UI updates.
- **Responsive UI:**  
  The layout adapts to different screen sizes and orientations (Portrait / Landscape).
- **Data Persistence:**  
  To satisfy the **V3 requirement**, cart data is stored locally, preserving user selections even after app restarts.
