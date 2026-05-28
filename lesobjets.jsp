<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Les objets</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les objets</h1>

<form action="#" method="post">
    <p>Saisir un nom : <input type="text" name="nom"></p>
    <p>Saisir un âge : <input type="text" name="age"></p>
    <p><input type="submit" value="Créer la personne"></p>
</form>

<%-- ============================================================
     DÉCLARATIONS DES CLASSES
     ============================================================ --%>
<%!
    // ----- Exercice 5 : Personne avec encapsulation -----
    class Personne {
        private String nom;
        private int age;

        // Getters
        public String getNom() { return nom; }
        public int getAge()    { return age; }

        // Setters
        public void setNom(String nom) { this.nom = nom; }
        public void setAge(int age)    { this.age = age; }

        // Exercice 2 : méthode seDecrire()
        public String seDecrire() {
            return "Je m'appelle " + nom + " et j'ai " + age + " ans";
        }
    }

    // ----- Exercice 1 : Classe Voiture -----
    class Voiture {
        String marque;
        String modele;
        int annee;
    }

    // ----- Exercice 3 : Classe Rectangle -----
    class Rectangle {
        double longueur;
        double largeur;

        public double calculerSurface() {
            return longueur * largeur;
        }
    }

    // ----- Exercice 4 : Classe CompteBancaire (solde encapsulé) -----
    class CompteBancaire {
        private double solde;

        public double getSolde() { return solde; }

        public void deposer(double montant) {
            solde += montant;
        }

        public void retirer(double montant) {
            solde -= montant;
        }
    }
%>

<%-- ============================================================
     RÉCUPÉRATION DU FORMULAIRE ET AFFICHAGE
     ============================================================ --%>
<%
    String nom = request.getParameter("nom");
    String age = request.getParameter("age");

    if (nom != null && age != null && !nom.isEmpty() && !age.isEmpty()) {
        try {
%>
            <%-- Création de l'objet Personne via setters (Exercice 5) --%>
            <%
                Personne p = new Personne();
                p.setNom(nom);
                p.setAge(Integer.parseInt(age));
            %>
            <p>Objet Personne créé !</p>
            <p>Nom : <%= p.getNom() %></p>
            <p>Age : <%= p.getAge() %> ans</p>

            <%-- Exercice 1 : La classe Voiture --%>
            <h2>Exercice 1 : La classe Voiture</h2>
            <%
                Voiture v = new Voiture();
                v.marque = "Renault";
                v.modele = "Clio";
                v.annee  = 2020;
            %>
            <p>Marque : <%= v.marque %></p>
            <p>Modèle : <%= v.modele %></p>
            <p>Année  : <%= v.annee %></p>

            <%-- Exercice 2 : Ajouter une méthode à la classe Personne --%>
            <h2>Exercice 2 : Ajouter une méthode à la classe Personne</h2>
            <p><%= p.seDecrire() %></p>

            <%-- Exercice 3 : La classe Rectangle --%>
            <h2>Exercice 3 : La classe Rectangle</h2>
            <%
                Rectangle r = new Rectangle();
                r.longueur = 5;
                r.largeur  = 3;
            %>
            <p>Longueur : <%= r.longueur %>, Largeur : <%= r.largeur %></p>
            <p>Surface : <%= r.calculerSurface() %></p>

            <%-- Exercice 4 : Le compte bancaire --%>
            <h2>Exercice 4 : Le compte bancaire</h2>
            <%
                CompteBancaire compte = new CompteBancaire();
                compte.deposer(100);
                compte.retirer(30);
            %>
            <p>Solde après dépôt de 100€ et retrait de 30€ : <%= compte.getSolde() %> €</p>

            <%-- Exercice 5 : L'encapsulation --%>
            <h2>Exercice 5 : L'encapsulation</h2>
            <p>Les attributs <code>nom</code> et <code>age</code> de la classe
            <code>Personne</code> sont <strong>privés</strong>.<br>
            On y accède uniquement via les getters et setters :<br>
            <code>getNom()</code>, <code>setNom(...)</code>,
            <code>getAge()</code>, <code>setAge(...)</code>.<br>
            Le <code>solde</code> de <code>CompteBancaire</code> est également
            privé, accessible via <code>getSolde()</code>.</p>

<%
        } catch (NumberFormatException e) {
%>
            <p style="color:red;">Erreur : l'âge doit être un nombre entier valide.</p>
<%
        }
    }
%>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
