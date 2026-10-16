-- Ajout de la nouvelle clé étrangère avec sa contrainte

ALTER TABLE Commande ADD column clientID VARCHAR(100) DEFAULT 'Client de passage',
ADD Constraint fk_commande_client FOREIGN KEY (clientID) REFERENCES Client(id);

-- INSERT CLIENT

INSERT INTO Client (id)
VALUES ('Client de passage');

INSERT INTO Client (id, Nom, Telephone, Email)
VALUES
    ('C001', 'Rakoto Jean', '0341234567', 'jean@gmail.com'),
    ('C002', 'Rasoa Marie', '0321234567', 'marie@gmail.com'),
    ('C003', 'Rabe Paul', '0331234567', 'paul@gmail.com'),
    ('C004', 'Andry Sarah', '0381234567', 'sarah@gmail.com');

-- INSERT DES COMMANDES DU CLIENT
 INSERT INTO CommandePlat (idCommande, idPlat, Quantite, PU)
VALUES
    (5, 1, 2, 7000),
    (5, 2, 1, 8000);
