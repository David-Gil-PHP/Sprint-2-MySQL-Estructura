-- Model Relacional amb el disseny de la base de dades. Si ho desitges, pots utilitzar draw.io, dbdiagram.io, Mysql Workbench o qualsevol altra eina que et permeti dibuixar l'estructura i exportar-la en format png o jpg (per a pujar-la al repositori). Et recomanem especialment genmymodel.com.
-- Script .sql de creació i càrrega de la base de dades.
DROP DATABASE IF EXISTS Optica;
CREATE DATABASE Optica;
USE Optica;

CREATE TABLE Adreça (
    id_adreça INT(10) UNSIGNED AUTO_INCREMENT,
    carrer VARCHAR(25),
    numero VARCHAR(10),
    pis VARCHAR(10),
    porta VARCHAR(10),
    ciutat VARCHAR(25),
    codi_postal INT(5),
    pais VARCHAR(25),
    PRIMARY KEY (id_adreça)
);

CREATE TABLE Proveidor (
    id_proveidor INT(10) UNSIGNED AUTO_INCREMENT,
    nom VARCHAR(25) UNIQUE,
    telefon VARCHAR(9) UNIQUE,
    fax VARCHAR(9) UNIQUE,
    nif VARCHAR(9) UNIQUE,
    id_adreça INT(10) UNSIGNED,
    PRIMARY KEY (id_proveidor),
    FOREIGN KEY (id_adreça) REFERENCES Adreça(id_adreça)
);

CREATE TABLE Marca (
    id_marca INT(10) UNSIGNED AUTO_INCREMENT,
    id_proveidor INT UNSIGNED,
    nom VARCHAR(50) UNIQUE,
    PRIMARY KEY (id_marca),
    FOREIGN KEY (id_proveidor) REFERENCES Proveidor(id_proveidor)
);

CREATE TABLE Ullera (
    id_ullera INT(10) UNSIGNED AUTO_INCREMENT,
    id_proveidor INT UNSIGNED,
    id_marca INT UNSIGNED,
    graduacio_vidre_esquerra DECIMAL(4,2),
    graduacio_vidre_dret DECIMAL(4,2),
    tipus_muntura ENUM('flotant', 'pasta', 'metàl·lica'),
    color_muntura VARCHAR(25),
    color_vidre_esquerra VARCHAR(25),
    color_vidre_dret VARCHAR(25),
    preu DECIMAL(6,2),
    PRIMARY KEY (id_ullera),
    FOREIGN KEY (id_proveidor) REFERENCES Proveidor(id_proveidor),
    FOREIGN KEY (id_marca) REFERENCES Marca(id_marca)
);

CREATE TABLE Cliente (
    id_client INT(10) UNSIGNED AUTO_INCREMENT,
    nom VARCHAR(25) UNIQUE,
    telefon VARCHAR(9) UNIQUE,
    email VARCHAR(25) UNIQUE,
    id_adreça INT(10) UNSIGNED,
    data_alta DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_client_recomanador INT(10) UNSIGNED UNIQUE,
    PRIMARY KEY (id_client),
    FOREIGN KEY (id_adreça) REFERENCES Adreça(id_adreça)
);

CREATE TABLE Empleat (
    id_empleat INT(10) UNSIGNED AUTO_INCREMENT,
    nom VARCHAR(25) UNIQUE,
    PRIMARY KEY (id_empleat)
);

CREATE TABLE Venda (
    id_venda INT(10) UNSIGNED AUTO_INCREMENT,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_empleat INT(10) UNSIGNED,
    id_ullera INT(10) UNSIGNED,
    id_client INT(10) UNSIGNED,
    PRIMARY KEY (id_venda),
    FOREIGN KEY (id_empleat) REFERENCES Empleat(id_empleat),
    FOREIGN KEY (id_ullera) REFERENCES Ullera(id_ullera),
    FOREIGN KEY (id_client) REFERENCES Cliente(id_client)
);