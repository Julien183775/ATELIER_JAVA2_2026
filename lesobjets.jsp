<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    // ============================================================
    // EXERCICE 5 : Classe Personne avec encapsulation
    // EXERCICE 2 : Méthode seDecrire()
    // ============================================================
    class Personne {
        private String nom;
        private int age;

        public Personne() {
        }

        public Personne(String nom, int age) {
            this.nom = nom;
            this.age = age;
        }

        public String getNom() {
            return nom;
        }

        public void setNom(String nom) {
            this.nom = nom;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            if (age >= 0) {
                this.age = age;
            }
        }

        public String seDecrire() {
            return "Je m'appelle " + nom + " et j'ai " + age + " ans.";
        }
    }

    // ============================================================
    // EXERCICE 1 : Classe Voiture
    // ============================================================
    class Voiture {
        String marque;
        String modele;
        int annee;
    }

    // ============================================================
    // EXERCICE 3 : Classe Rectangle
    // ============================================================
    class Rectangle {
        double longueur;
        double largeur;

        public double calculerSurface() {
            return longueur * largeur;
        }
    }

    // ============================================================
    // EXERCICE 4 : Classe CompteBancaire
    // ============================================================
    class CompteBancaire {
        private double solde;

        public double getSolde() {
            return solde;
        }

        public void deposer(double montant) {
            if (montant > 0) {
                solde = solde + montant;
            }
        }

        public void retirer(double montant) {
            if (montant > 0 && montant <= solde) {
                solde = solde - montant;
            }
        }
    }
%>

<html>
<head>
    <title>Les objets</title>
</head>

<body bgcolor="white">

<h1>Exercices sur les objets</h1>

<!-- ============================================================
     FORMULAIRE POUR LES EXERCICES PERSONNE
     ============================================================ -->
<form action="#" method="post">
    <p>
        <label for="nom">Saisir un nom : </label>
        <input type="text" id="nom" name="nom" required>
    </p>

    <p>
        <label for="age">Saisir un âge : </label>
        <input type="number" id="age" name="age" min="0" required>
    </p>

    <p>
        <input type="submit" value="Créer la personne">
    </p>
</form>

<hr>

<!-- ============================================================
     EXERCICE 1 : VOITURE
     ============================================================ -->
<h2>Exercice 1 : La classe Voiture</h2>

<%
    Voiture voiture = new Voiture();

    voiture.marque = "Renault";
    voiture.modele = "Clio";
    voiture.annee = 2020;
%>

<p>Objet Voiture créé !</p>
<p>Marque : <%= voiture.marque %></p>
<p>Modèle : <%= voiture.modele %></p>
<p>Année : <%= voiture.annee %></p>

<hr>

<!-- ============================================================
     RÉCUPÉRATION DES INFORMATIONS DE LA PERSONNE
     ============================================================ -->
<%
    String nomSaisi = request.getParameter("nom");
    String ageSaisi = request.getParameter("age");

    if (nomSaisi != null && ageSaisi != null
            && !nomSaisi.trim().isEmpty()
            && !ageSaisi.trim().isEmpty()) {

        try {
            int ageConverti = Integer.parseInt(ageSaisi);

            Personne personne = new Personne();
            personne.setNom(nomSaisi);
            personne.setAge(ageConverti);
%>

<!-- ============================================================
     EXERCICE 2 : MÉTHODE seDecrire()
     ============================================================ -->
<h2>Exercice 2 : Ajouter une méthode à la classe Personne</h2>

<p>Objet Personne créé !</p>
<p>Nom : <%= personne.getNom() %></p>
<p>Âge : <%= personne.getAge() %> ans</p>

<p><strong>Description :</strong> <%= personne.seDecrire() %></p>

<hr>

<!-- ============================================================
     EXERCICE 5 : ENCAPSULATION
     ============================================================ -->
<h2>Exercice 5 : L'encapsulation</h2>

<p>Les attributs de la personne sont privés.</p>
<p>Nom obtenu avec <code>getNom()</code> : <%= personne.getNom() %></p>
<p>Âge obtenu avec <code>getAge()</code> : <%= personne.getAge() %> ans</p>

<%
        } catch (NumberFormatException e) {
%>

<p>Erreur : veuillez saisir un âge valide.</p>

<%
        }
    }
%>

<hr>

<!-- ============================================================
     EXERCICE 3 : RECTANGLE
     ============================================================ -->
<h2>Exercice 3 : La classe Rectangle</h2>

<%
    Rectangle rectangle = new Rectangle();

    rectangle.longueur = 5;
    rectangle.largeur = 3;
%>

<p>Longueur : <%= rectangle.longueur %></p>
<p>Largeur : <%= rectangle.largeur %></p>
<p>Surface : <%= rectangle.calculerSurface() %></p>

<hr>

<!-- ============================================================
     EXERCICE 4 : COMPTE BANCAIRE
     ============================================================ -->
<h2>Exercice 4 : Le compte bancaire</h2>

<%
    CompteBancaire compte = new CompteBancaire();

    compte.deposer(100);
    compte.retirer(30);
%>

<p>Dépôt effectué : 100 €</p>
<p>Retrait effectué : 30 €</p>
<p>Solde final : <%= compte.getSolde() %> €</p>

<hr>

<p><a href="index.html">Retour au sommaire</a></p>

</body>
</html>
