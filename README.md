# Random User Data App

This project demonstrates the implementation of an app that fetches random user data from the network using pagination. The app displays user information such as their image, full name, and location in either a list or grid view.

## Overview

- This app fetches random user data from a network API with pagination support, ensuring smooth loading of additional data as users scroll through the list or grid. The fetched user data is displayed in a list or grid format, showing details like the user's image, full name, and location.

## Key Features

- Random User Fetching: The app uses pagination to load random user data from an API. As the user scrolls, more data is fetched and appended to the current view.
- List and Grid Views: Users can switch between list and grid views to see the fetched data. The list view shows user information in a vertical list, while the grid view presents them in a grid format.
- User Information: The app displays key information for each user: Profile Image, Full Name, Location (Street, City and Country)

## Network and Data Management

- Pagination: To improve performance and user experience, the app implements pagination, loading more users as the user scrolls further down the list or grid.
- Asynchronous Network Requests: The app uses asynchronous network requests to fetch user data efficiently, ensuring that the UI remains responsive even while new data is being loaded.

## Memory Management

- Efficient Data Loading: To avoid memory issues, the app loads images and other user data in an optimized manner, ensuring that resources are efficiently used and released when no longer needed.
