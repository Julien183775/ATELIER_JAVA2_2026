<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Les constructeurs</title>
</head>

<body bgcolor="white">

<h1>Exercices sur les constructeurs</h1>

<form action="#" method="post">
    <p>
        <label for="titre">Saisir un titre de livre :</label>
        <input type="text" id="titre" name="titre" required>
    </p>
    <p>
        <label for="auteur">Saisir un auteur :</label>
        <input type="text" id="auteur" name="auteur" required>
    </p>
    <p>
        <input type="submit" value="Créer les livres">
    </p>
</form>

<%!
    class Livre {
        private String titre;
        private String auteur;

        public Livre() {
            this.titre = "Titre inconnu";
            this.auteur = "Auteur inconnu";
        }

        public Livre(String titre, String auteur) {
            this.titre = titre;
            this.auteur = auteur;
        }

        public String getTitre() { return titre; }
        public String getAuteur() { return auteur; }
    }

    class Etudiant {
        private String nom;
        private double note;

        public Etudiant() {
            this("Anonyme", 10);
        }

        public Etudiant(String nom) {
            this(nom, 10);
        }

        public Etudiant(String nom, double note) {
            this.nom = nom;
            this.note = note;
        }

        public Etudiant(Etudiant autre) {
            this(autre.getNom(), autre.getNote());
        }

        public String getNom() { return nom; }
        public double getNote() { return note; }
    }

    class Produit {
        private double prix;

        public Produit(double prix) {
            this.prix = (prix < 0) ? 0 : prix;
        }

        public double getPrix() { return prix; }
    }
%>

<%
    String titre = request.getParameter("titre");
    String auteur = request.getParameter("auteur");

    if (titre != null && auteur != null
            && !titre.trim().isEmpty()
            && !auteur.trim().isEmpty()) {
%>

<hr>

<p>Livre créé via le constructeur par défaut :</p>
<%
    Livre l1 = new Livre();
%>
<p>Titre : <%= l1.getTitre() %> - Auteur : <%= l1.getAuteur() %></p>

<p>Livre créé via le constructeur avec paramètres :</p>
<%
    Livre l2 = new Livre(titre.trim(), auteur.trim());
%>
<p>Titre : <%= l2.getTitre() %> - Auteur : <%= l2.getAuteur() %></p>

<h2>Exercice 1 : Le constructeur par défaut</h2>
<%
    Etudiant e1 = new Etudiant();
%>
<p>Nom : <%= e1.getNom() %> - Note : <%= e1.getNote() %></p>

<h2>Exercice 2 : La surcharge de constructeurs</h2>
<%
    Etudiant e2 = new Etudiant("Alice");
    Etudiant e3 = new Etudiant("Bob", 17);
%>
<p>Constructeur sans paramètre → Nom : <%= e1.getNom() %> - Note : <%= e1.getNote() %></p>
<p>Constructeur avec nom seul → Nom : <%= e2.getNom() %> - Note : <%= e2.getNote() %></p>
<p>Constructeur avec nom + note → Nom : <%= e3.getNom() %> - Note : <%= e3.getNote() %></p>

<h2>Exercice 3 : Chaîner les constructeurs avec this()</h2>
<p>Le constructeur sans paramètre appelle <code>this("Anonyme", 10)</code> pour éviter la duplication du code d'initialisation.</p>
<p>Résultat : Nom : <%= e1.getNom() %> - Note : <%= e1.getNote() %></p>

<h2>Exercice 4 : Le constructeur de copie</h2>
<%
    Etudiant original = new Etudiant("Marie", 15);
    Etudiant copie = new Etudiant(original);
%>
<p>Original → Nom : <%= original.getNom() %> - Note : <%= original.getNote() %></p>
<p>Copie → Nom : <%= copie.getNom() %> - Note : <%= copie.getNote() %></p>

<h2>Exercice 5 : Valider les paramètres dans le constructeur</h2>
<%
    Produit p = new Produit(-50);
%>
<p>Produit créé avec un prix de -50 €.</p>
<p>Prix appliqué : <%= String.format("%.2f", p.getPrix()) %> € (prix négatif forcé à 0)</p>

<%
    }
%>

<p><a href="index.html">Retour au sommaire</a></p>

</body>
</html>
