-- ETAPE 1&2
CREATE TABLE CategoriePlat(
    id SERIAL PRIMARY KEY,
    Libelle VARCHAR(50) NOT NULL
);

CREATE TABLE Plat(
    id SERIAL PRIMARY KEY,
    NomPlat VARCHAR(100) NOT NULL,
    idCategorie INT NOT NULL,
    PRIX INT NOT NULL,

    FOREIGN KEY (idCategorie) REFERENCES CategoriePlat(id)
);

-- Données d'insertions

INSERT INTO CategoriePlat (Libelle) VALUES 
('plats malagasy'),
('plats chinois'),
('soupes'),
('desserts et goûter'),
('boissons');

INSERT INTO Plat (NomPlat,idCategorie,PRIX) VALUES
('Romazava',1,7000),
('Ravitoto sy henakisoa',1,8000),
('Akoho sy voanio',1,8500),
('Mi sao',2,6000),
('Soupe chinoise',3,5000),
('Mofo gasy',4,1000),
('Ranon''ampango',5,500);

-- Etape 3 commande
-- CREATE TABLE Commande(
--     id SERIAL PRIMARY KEY,
--     Date Date
-- );

-- CREATE TABLE CommandePlat(
--     id SERIAL PRIMARY KEY,
--     idCommande INT NOT NULL,
--     idPlat INT NOT NULL,
--     Quantite INT NOT NULL,
--     PU INT NOT NULL,
--     -- montant INT NOT NULL,

--     FOREIGN KEY (idCommande) REFERENCES Commande(id),
--     FOREIGN KEY (idPlat) REFERENCES Plat(id)
-- );

-- Données de test
    INSERT INTO Commande (Date)
VALUES
    ('2026-10-10'),
    ('2026-10-12'),
    ('2026-10-15'),
    ('2026-10-16');

    INSERT INTO CommandePlat
    (idCommande, idPlat, Quantite, PU)
VALUES
    -- Commande 1
    (1, 1, 2, 7000),
    (1, 2, 1, 8000),

    -- Commande 2
    (2, 4, 2, 6000),
    (2, 5, 1, 5000),
    (2, 7, 2, 500),

    -- Commande 3
    (3, 3, 1, 8500),
    (3, 6, 5, 1000),

    -- Commande 4
    (4, 1, 1, 7000),
    (4, 4, 3, 6000),
    (4, 6, 2, 1000);

--
CREATE VIEW detailCommande AS
SELECT c.id,
c.Date,
p.NomPlat,
p.PRIX,
cp.Quantite,
cp.PU,
(cp.Quantite *cp.PU) as montant
FROM Commande c
JOIN CommandePlat cp on c.id = cp.idCommande
JOIN Plat p ON cp.idPlat =p.id; 

-- Etape 4
CREATE TABLE Client(
    id VARCHAR(100) PRIMARY KEY,
    Nom VARCHAR(100) DEFAULT 'pas enregistré',
    Telephone VARCHAR(100) DEFAULT 'pas enregistré',
    Email VARCHAR(100) DEFAULT 'pas enregistré'
);
-- ALTER TABLE Client ALTER COLUMN Nom DROP NOT NULL;
-- ALTER TABLE Client ALTER COLUMN Nom Set DEFAULT 'pas enregistré';

ALTER TABLE Commande ADD column clientID VARCHAR(100) DEFAULT 'Client de passage',
ADD Constraint fk_commande_client FOREIGN KEY (clientID) REFERENCES Client(id);

-- ALTER TABLE Client ADD Constraint fk_idClient PRIMARY KEY (id);
-- ALTER TABLE Client DROP Constraint fk_idClient ;


CREATE TABLE Commande(
    id SERIAL PRIMARY KEY,
    Date Date,
    clientID VARCHAR(100) DEFAULT 'Client de passage',
    FOREIGN KEY (clientID) REFERENCES Client(id)
);

CREATE TABLE CommandePlat(
    id SERIAL PRIMARY KEY,
    idCommande INT NOT NULL,
    idPlat INT NOT NULL,
    Quantite INT NOT NULL,
    PU INT NOT NULL,
    -- montant INT NOT NULL,

    FOREIGN KEY (idCommande) REFERENCES Commande(id),
    FOREIGN KEY (idPlat) REFERENCES Plat(id)
);


-- Donnée de test

INSERT INTO Client (id, Nom, Telephone, Email)
VALUES
    ('C001', 'Rakoto Jean', '0341234567', 'jean@gmail.com'),
    ('C002', 'Rasoa Marie', '0321234567', 'marie@gmail.com'),
    ('C003', 'Rabe Paul', '0331234567', 'paul@gmail.com'),
    ('C004', 'Andry Sarah', '0381234567', 'sarah@gmail.com');


CREATE TABLE TypePaiement(
    id SERIAL PRIMARY KEY,
    Libelle VARCHAR(100) NOT NULL
);

INSERT INTO TypePaiement(Libelle) VALUES
('Especes'),
('Mvola'),
('Orange Money'),
('AirtelMoney');

CREATE TABLE PaiementCommande(
    id SERIAL PRIMARY KEY,
    idTypePaiements INT NOT NULL,
    idCommande INT NOT NULL,
    Date date,

    Montant INT NOT NULL,
    FOREIGN KEY (idTypePaiements) TypePaiement(id),
    FOREIGN KEY (idCommande) Commande(id)
);



-- view liste des commandes non soldées et reste a payer
CREATE VIEW detailCommande AS
SELECT c.id,
c.Date,
p.NomPlat,
p.PRIX,
cp.Quantite,
cp.PU,
(cp.Quantite *cp.PU) as montant
FROM Commande c
JOIN CommandePlat cp on c.id = cp.idCommande
JOIN Plat p ON cp.idPlat =p.id; 

CREATE VIEW listeCommandeNonSolde as
select d.id,
COALESCE()d.sum(montant) AS MontantTotalAPayer ,
p.sum(Montant) AS MontantPayer,
(MontantTotalAPayer - MontantPayer)AS reste
from detailCommande d JOIN PaiementCommande p on d.id = p.idCommande 
where reste <0;




-- Donne de test

INSERT INTO PaiementCommande (idTypePaiements, idCommande, Date, Montant) VALUES
(1, 1, '2026-10-10', 22000),   -- commande 1 : soldée en espèces
(2, 2, '2026-10-12', 10000),   -- commande 2 : paiement partiel par Mvola (reste 8000)
(3, 3, '2026-10-15', 13500),   -- commande 3 : soldée via Orange Money
(1, 4, '2026-10-16', 15000);   -- commande 4 : paiement partiel en espèces (reste 12000)