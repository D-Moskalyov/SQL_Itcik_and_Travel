CREATE DATABASE Travel
--DROP DATABASE Travel
USE Travel
--USE northwind

CREATE TABLE TravelAgents
(
	AgentsID int IDENTITY(1,1) PRIMARY KEY,
	Title varchar(255)
)
CREATE TABLE Clients
(
	ClientID int IDENTITY(1,1) PRIMARY KEY,
	FirsName varchar(255),
	LastName varchar(255),
	Country varchar(255),
	City varchar(255)
)
CREATE TABLE Hotels
(
	HotelID int IDENTITY(1,1) PRIMARY KEY,
	Tax int,
	Title varchar(255),
	Country varchar(255),
	City varchar(255)
)
CREATE TABLE Transports
(
	TransportID int IDENTITY(1,1) PRIMARY KEY,
	Title varchar(255)
)
CREATE TABLE Visas
(
	VisaID int PRIMARY KEY,
	Kind varchar(255),
	ClientID int
)
CREATE TABLE RepresentativesOfAgents
(
	Representative int IDENTITY(1,1) PRIMARY KEY,
	AgentsID int,
	Country varchar(255),
	City varchar(255)
)
CREATE TABLE RepresentativesOfTransports
(
	Representative int IDENTITY(1,1) PRIMARY KEY,
	TransportID int,
	Country varchar(255),
	City varchar(255)
)
CREATE TABLE Tours
(
	Tour int IDENTITY(1,1) PRIMARY KEY,
	AgentsID int,
	Duration int,
	Country varchar(255),
	City varchar(255),
	HotelID int,
	VisaKind varchar(255)
)

INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (800, 'Hilton', 'England', 'London')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (600, 'Accor', 'England', 'London')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (800, 'Marriott', 'Spain', 'Barcelona')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (700, 'AZIMUT', 'Italy', 'Milan')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (700, 'AZIMUT', 'Italy', 'Rome')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (1000, 'Hilton', 'France', 'Nice')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (500, 'AMAKS', 'France', 'Paris')
INSERT INTO Hotels (Tax, Title, Country, City) 
VALUES (500, 'Hilton', 'Greece', 'Athens')

INSERT INTO TravelAgents (Title) 
VALUES ('TUI')
INSERT INTO TravelAgents (Title) 
VALUES ('Arizona')

INSERT INTO Transports (Title) 
VALUES ('Lufthansa')
INSERT INTO Transports (Title) 
VALUES ('Air France')

INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Майкрофт', 'Холмс', 'England', 'London')
INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Шерлок', 'Холмс', 'England', 'London')
INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Джон', 'Ватсон', 'France', 'Nice')
INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Грег', 'Лестрейд', 'Spain', 'Barcelona')
INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Джеймс', 'Мориарти', 'Italy', 'Roma')
INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Молли', 'Хупер', 'Greece', 'Athens')
INSERT INTO Clients (FirsName, LastName, Country, City) 
VALUES ('Миссис', 'Хадсон', 'England', 'Liverpool')

INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (11111, 'GreeceVis', 0)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (22222, 'ItalyVis', 0)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (33333, 'FranceVis', 1)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (44444, 'ItalyVis', 1)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (55555, 'SapinVis', 2)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (66666, 'GreeceVis', 3)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (77777, 'EnglandVis', 3)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (88888, 'FranceVis', 3)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (99999, 'FranceVis', 4)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (10101, 'SapinVis', 4)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (20202, 'SapinVis', 4)
INSERT INTO Visas (VisaID, Kind, ClientID) 
VALUES (30303, 'EnglandVis', 4)

INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (0, 'England', 'London')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (0, 'France', 'Paris')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (0, 'France', 'Nice')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (0, 'Spain', 'Barcelona')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (0, 'Greece', 'Athens')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (1, 'England', 'London')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (1, 'France', 'Paris')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (1, 'France', 'Nice')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (1, 'Spain', 'Barcelona')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (1, 'Greece', 'Athens')
INSERT INTO RepresentativesOfAgents (AgentsID, Country, City) 
VALUES (1, 'Italy', 'Roma')

INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (0, 'England', 'London')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (0, 'France', 'Paris')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (0, 'France', 'Nice')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (0, 'Spain', 'Barcelona')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (0, 'Greece', 'Athens')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (0, 'Italy', 'Roma')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (1, 'England', 'London')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (1, 'France', 'Paris')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (1, 'France', 'Nice')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (1, 'Spain', 'Barcelona')
INSERT INTO RepresentativesOfTransports (TransportID, Country, City) 
VALUES (1, 'Greece', 'Athens')

INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 10, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')
INSERT INTO Tours (AgentsID, Duration, Country, City, HotelID, VisaKind)
VALUES (0, 5, 'England', 'London', 0, 'EnglandVis')

--SELECT * from Travel