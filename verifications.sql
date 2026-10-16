-- Verification etapes 1 & 2

SELECT * from Plat;

-- Verifications Commande Etape 3
SELECT c.id,
c.id,
c.Date,
p.NomPlat,
p.PRIX,
cp.Quantite,
cp.PU,
(cp.Quantite *cp.PU) as montant
FROM Commande c
JOIN CommandePlat cp on c.id = cp.idCommande
JOIN Plat p ON cp.idPlat =p.id;


INSERT INTO Commande (Date, clientID)
VALUES
    ('2026-10-10', 'C001');

    -- verification etape 4
SELECT c.id,
c.id,
c.Date,
p.NomPlat,
p.PRIX,
cp.Quantite,
cp.PU,
c.clientID,
(cp.Quantite *cp.PU) as montant
FROM Commande c
JOIN CommandePlat cp on c.id = cp.idCommande
JOIN Plat p ON cp.idPlat =p.id;