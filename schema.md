# Etape 1 & 2
## Table plat
<p>CREATE TABLE Plat(</p>
    <p> <strong style="font-weight: 900;">id</strong> INT SERIAL PRIMARY KEY,</p>
    <p style="margin-left:2%">NomPlat VARCHAR(100) NOT NULL,</p>
    <p style="margin-left:2%">#idCategorie INT NOT NULL,</p>
    <p style="margin-left:2%">PRIX INT NOT NULL,</p>
    <p style="margin-left:2%">FOREIGN KEY (idCategorie) REFERENCES CategoriePlat(id)</p>
);

## Table Categorie
<p>CREATE TABLE CategoriePlat( </p>
    <p style="margin-left:2%"> <strong style="font-weight: 900;">id</strong> INT SERIAL PRIMARY KEY,</p>
    <p style="margin-left:2%">Libelle VARCHAR(50) NOT NULL</p>
);

## Piege
- Le type de prix est un INT simple car les prix sont des entieres simple pas de 7500,50 Ar
- Categorie doit être une table a part pour plus de modulabilité , car en cas d'ajout de nouvelle catégorie , ou d'update de nom c'est plus facile avec un id déja associé avec

# Etape 3

<p>CREATE TABLE Commande( </p>
    <p style="margin-left:2%">id SERIAL PRIMARY KEY,</p>
    <p style="margin-left:2%">Date Date</p>
);

<p>CREATE TABLE CommandePlat( </p>
    <p style="margin-left:2%"><strong style="font-weight: 900;">id</Strong> SERIAL PRIMARY KEY, </p>
    <p style="margin-left:2%">#idCommande INT NOT NULL, </p>
    <p style="margin-left:2%">#idPlat INT NOT NULL, </p>
    <p style="margin-left:2%">Quantite INT NOT NULL, </p>
    <p style="margin-left:2%">PU INT NOT NULL, </p>
    <p style="margin-left:2%">FOREIGN KEY (idCommande) REFERENCES Commande(id), </p>
    <p style="margin-left:2%">FOREIGN KEY (idPlat) REFERENCES Plat(id) </p>
);

## Piege
- On doit créer une table à part une table associatif faisant le lien entre Commande et les Plats ,c'est dans cette table associatif que l'on met quantite

# Etape 4

<p>CREATE TABLE Client( <p>
    <p style="margin-left:2%"> <strong style="font-weight: 900;">id</strong> VARCHAR(100) PRIMARY KEY, </p>
    <p style="margin-left:2%">Nom VARCHAR(100) DEFAULT 'pas enregistré', </p>
    <p style="margin-left:2%">Telephone VARCHAR(100) DEFAULT 'pas enregistré', </p>
    <p style="margin-left:2%">Email VARCHAR(100) DEFAULT 'pas enregistré' </p>
);

## Piege
- Ma clé étrangère a une valeur par défaut  vu que j'ai des valeur par défaut donc un simple JOIN suffit


# CHECK migrations_commande.sql
