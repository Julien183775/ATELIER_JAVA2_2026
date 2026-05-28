<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Les constructeurs</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les constructeurs</h1>

<form action="#" method="post">
    <p>Saisir un titre de livre : <input type="text" name="titre"></p>
    <p>Saisir un auteur : <input type="text" name="auteur"></p>
    <p><input type="submit" value="Créer les livres"></p>
</form>

<%-- ============================================================
     DÉCLARATIONS DES CLASSES
     ============================================================ --%>
<%!
    // ----- Classe Livre : constructeur par défaut + constructeur avec paramètres -----
    class Livre {
        private String titre;
        private String auteur;

        // Constructeur par défaut
        public Livre() {
            this.titre  = "Titre inconnu";
            this.auteur = "Auteur inconnu";
        }

        // Constructeur avec paramètres
        public Livre(String titre, String auteur) {
            this.titre  = titre;
            this.auteur = auteur;
        }

        public String getTitre()  { return titre; }
        public String getAuteur() { return auteur; }
    }

    // ----- Exercices 1, 2, 3, 4 : Classe Etudiant -----
    class Etudiant {
        private String nom;
        private double note;

        // Exercice 3 : constructeur sans paramètre qui chaîne avec this()
        public Etudiant() {
            this("Anonyme", 10);   // appelle le constructeur (nom, note)
        }

        // Exercice 2 : constructeur avec nom uniquement (note = 10 par défaut)
        public Etudiant(String nom) {
            this(nom, 10);         // appelle le constructeur (nom, note)
        }

        // Exercice 2 : constructeur avec nom et note
        public Etudiant(String nom, double note) {
            this.nom  = nom;
            this.note = note;
        }

        // Exercice 4 : constructeur de copie
        public Etudiant(Etudiant autre) {
            this.nom  = autre.nom;
            this.note = autre.note;
        }

        public String getNom()   { return nom; }
        public double getNote()  { return note; }
    }

    // ----- Exercice 5 : Classe Produit avec validation du prix -----
    class Produit {
        private double prix;

        public Produit(double prix) {
            // Si le prix est négatif, on le force à 0
            this.prix = (prix < 0) ? 0 : prix;
        }

        public double getPrix() { return prix; }
    }
%>

<%-- ============================================================
     RÉCUPÉRATION DU FORMULAIRE ET AFFICHAGE
     ============================================================ --%>
<%
    String titre  = request.getParameter("titre");
    String auteur = request.getParameter("auteur");

    if (titre != null && auteur != null && !titre.isEmpty() && !auteur.isEmpty()) {
%>
        <%-- Livre via constructeur par défaut --%>
        <%  Livre l1 = new Livre(); %>
        <p>Livre créé via le constructeur par défaut :</p>
        <p>Titre : <%= l1.getTitre() %> - Auteur : <%= l1.getAuteur() %></p>

        <%-- Livre via constructeur avec paramètres --%>
        <%  Livre l2 = new Livre(titre, auteur); %>
        <p>Livre créé via le constructeur avec paramètres :</p>
        <p>Titre : <%= l2.getTitre() %> - Auteur : <%= l2.getAuteur() %></p>

        <%-- Exercice 1 : constructeur par défaut (via chaînage ex3) --%>
        <h2>Exercice 1 : Le constructeur par défaut</h2>
        <%  Etudiant e1 = new Etudiant(); %>
        <p>Etudiant créé avec le constructeur par défaut :</p>
        <p>Nom : <%= e1.getNom() %> - Note : <%= e1.getNote() %></p>

        <%-- Exercice 2 : surcharge des constructeurs --%>
        <h2>Exercice 2 : La surcharge de constructeurs</h2>
        <%
            Etudiant e2 = new Etudiant();             // constructeur sans paramètre
            Etudiant e3 = new Etudiant("Alice");      // constructeur avec nom uniquement
            Etudiant e4 = new Etudiant("Bob", 17);    // constructeur avec nom et note
        %>
        <p>Constructeur sans paramètre → Nom : <%= e2.getNom() %> - Note : <%= e2.getNote() %></p>
        <p>Constructeur avec nom seul  → Nom : <%= e3.getNom() %> - Note : <%= e3.getNote() %></p>
        <p>Constructeur avec nom+note  → Nom : <%= e4.getNom() %> - Note : <%= e4.getNote() %></p>

        <%-- Exercice 3 : chaînage avec this() --%>
        <h2>Exercice 3 : Chaîner les constructeurs avec this()</h2>
        <p>Le constructeur sans paramètre appelle <code>this("Anonyme", 10)</code>
           pour éviter la duplication du code d'initialisation.</p>
        <%  Etudiant e5 = new Etudiant(); %>
        <p>Résultat : Nom : <%= e5.getNom() %> - Note : <%= e5.getNote() %></p>

        <%-- Exercice 4 : constructeur de copie --%>
        <h2>Exercice 4 : Le constructeur de copie</h2>
        <%
            Etudiant original = new Etudiant("Marie", 15);
            Etudiant copie    = new Etudiant(original);   // constructeur de copie
        %>
        <p>Original → Nom : <%= original.getNom() %> - Note : <%= original.getNote() %></p>
        <p>Copie    → Nom : <%= copie.getNom() %>    - Note : <%= copie.getNote() %></p>

        <%-- Exercice 5 : validation dans le constructeur --%>
        <h2>Exercice 5 : Valider les paramètres dans le constructeur</h2>
        <%  Produit p = new Produit(-50); %>
        <p>Produit créé avec un prix de -50€.</p>
        <p>Prix réel appliqué : <%= p.getPrix() %> €
           (le prix négatif a été forcé à 0)</p>

<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
