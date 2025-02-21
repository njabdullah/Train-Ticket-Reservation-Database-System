# Train Ticket Reservation Database System
### Repository Description

This repository contains a project for creating a database system for train ticket reservations. The project was developed by Group 2 of the Database Management F 2023 class as part of the final project for the Database Management course.

---

### Project Description

The Train Ticket Reservation Database System project is a database designed to facilitate the process of booking train tickets. This database has several important features, such as storing user account information, the ability to order food, seat selection options, and common functions in train ticket booking.

In this database, there are 8 entities, each with its own role:
1. The "Customer" entity aims to store information about user accounts making reservations.
2. The "Train" entity is used to store data about trains that can be booked, including train names, departure times, and initial stations.
3. The "Food_Menu" entity is used to store a list of food menus along with their prices for each train.
4. The "Reservation_Transaction" entity is used to record all train booking transactions made by customers.
5. The "Feedback" entity is used to store feedback provided by each customer.
6. The "Passenger_Detail_Transaction" entity aims to store complete information about each passenger who is not the customer.
7. The "Seat" entity is used to manage and monitor the availability of seats on each train journey.
8. The "Food_Transaction" entity is used to record all information on food ordering transactions made by customers.

---
### Features

This project uses SQL to manage and manipulate the database. Here are some of the main features implemented using SQL:

1. Sequence: In this database structure, there is the use of automatic numbering (sequences) that has been set up. This allows for the automatic generation of unique IDs when there is an addition or change of data in the database.
2. "Seat_Arrangement_Func()" Function: This function is designed to automatically arrange the numbering of available seats on each train. Thus, users do not need to manually input this numbering.
3. "Available_Func()" Function: This function is used to provide a message if the seat the user wants to book is unavailable. This function plays an important role in providing accurate information about seat availability to users.
4. "update_available_seat()" Function: This function aims to change the availability status of seats in the seat entity after the seat has been successfully booked. This ensures that seat availability information remains up-to-date in the database.
5. Triggers: There are several triggers implemented in this database. For example, triggers to execute the "seat_arrangement_func()" function when there is a change in the train entity, triggers to execute the "available_func()" function when there is a change in the passenger_detail_transaction entity, and triggers to execute the "update_available_seat()" function when there is a change in the passenger_detail_transaction entity.
6. Indexing:
   ```
   CREATE INDEX idx_name ON train (train_name);
   CREATE INDEX idx_departure_date ON train (departure_date);
   ```
   Used to speed up search processes based on train name and departure date. These indexes help optimize the time required for data search.
7. Views: In this database, several table views have been created, allowing users to obtain desired information without altering existing entities. Some examples of these table views include revenue for each train, seat availability, food orders, and a list of trains most preferred by customers.

---
### Installation and Usage

Clone this repository to your local machine.
   ```
   git clone https://github.com/njabdullah/Train-Ticket-Reservation-Database-System.git
   ```

After following the above steps, you can run the project and start using the provided SQL features.
