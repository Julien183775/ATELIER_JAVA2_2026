<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Le polymorphisme</title>
</head>
<body bgcolor=white>
<h1>Exercices sur le polymorphisme</h1>

<form action="#" method="post">
    <p>Saisir le nom d'un chien : <input type="text" name="nomChien"></p>
    <p>Saisir le nom d'un chat : <input type="text" name="nomChat"></p>
    <p><input type="submit" value="Faire crier les animaux"></p>
</form>

<%-- ============================================================
     DÉCLARATIONS DES CLASSES ET INTERFACES
     ============================================================ --%>
<%!
    // ----- Interface Affichable (Exercice 3) -----
    interface Affichable {
        void afficher();
    }

    // ----- Classe abstraite Animal (base + Exercice 1 : toString) -----
    abstract class Animal {
        protected String nom;

        public Animal(String nom) {
            this.nom = nom;
        }

        // Méthode abstraite : chaque sous-classe DOIT l'implémenter
        public abstract String crier();

        // Exercice 1 : toString() dans la classe mère (version générique)
        public String toString() {
            return "Animal nommé " + nom;
        }
    }

    // ----- Classe Chien (Exercices 1, 2, 3) -----
    class Chien extends Animal implements Affichable {

        public Chien(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return nom + " dit : Wouf wouf !";
        }

        // Exercice 1 : toString() redéfini dans Chien
        @Override
        public String toString() {
            return "Chien nommé " + nom;
        }

        // Exercice 3 : méthode de l'interface Affichable
        @Override
        public void afficher() {
            // stocke le résultat dans un champ pour pouvoir l'afficher en JSP
        }

        public String getAffichage() {
            return "Affichage Chien → " + toString();
        }
    }

    // ----- Classe Chat (Exercices 1, 2, 3) -----
    class Chat extends Animal implements Affichable {

        public Chat(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return nom + " dit : Miaou !";
        }

        // Exercice 1 : toString() redéfini dans Chat
        @Override
        public String toString() {
            return "Chat nommé " + nom;
        }

        // Exercice 3 : méthode de l'interface Affichable
        @Override
        public void afficher() {
            // idem
        }

        public String getAffichage() {
            return "Affichage Chat → " + toString();
        }
    }

    // ----- Exercice 4 : Classe Oiseau -----
    class Oiseau extends Animal {

        public Oiseau(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return nom + " dit : Cui cui !";
        }

        @Override
        public String toString() {
            return "Oiseau nommé " + nom;
        }
    }

    // ----- Exercice 2 : Classe abstraite Forme -----
    abstract class Forme {
        public abstract double aire();
    }

    class Cercle extends Forme {
        private double rayon;

        public Cercle(double rayon) {
            this.rayon = rayon;
        }

        @Override
        public double aire() {
            return Math.PI * rayon * rayon;
        }

        public String toString() {
            return "Cercle (rayon=" + rayon + ")";
        }
    }

    class Carre extends Forme {
        private double cote;

        public Carre(double cote) {
            this.cote = cote;
        }

        @Override
        public double aire() {
            return cote * cote;
        }

        public String toString() {
            return "Carré (côté=" + cote + ")";
        }
    }
%>

<%-- ============================================================
     RÉCUPÉRATION DU FORMULAIRE ET AFFICHAGE
     ============================================================ --%>
<%
    String nomChien = request.getParameter("nomChien");
    String nomChat  = request.getParameter("nomChat");

    if (nomChien != null && nomChat != null && !nomChien.isEmpty() && !nomChat.isEmpty()) {

        Chien  chien  = new Chien(nomChien);
        Chat   chat   = new Chat(nomChat);
        Oiseau oiseau = new Oiseau("Titi");

        // Tableau Animal[] contenant les 3 animaux (Exercice 4 : Oiseau ajouté sans toucher à la boucle)
        Animal[] animaux = { chien, chat, oiseau };
%>
        <%-- Démonstration du polymorphisme (boucle de base) --%>
        <p>Démonstration du polymorphisme :<br>
        Le tableau est déclaré <code>Animal[]</code>, mais c'est bien la méthode
        <code>crier()</code> de la sous-classe (Chien, Chat ou Oiseau) qui est appelée à l'exécution.</p>
        <%
            for (Animal a : animaux) {
        %>
            <p><%= a.crier() %></p>
        <%
            }
        %>

        <%-- Exercice 1 : toString() --%>
        <h2>Exercice 1 : Redéfinir toString()</h2>
        <%
            for (Animal a : animaux) {
        %>
            <p><%= a.toString() %></p>
        <%
            }
        %>

        <%-- Exercice 2 : Classe abstraite Forme --%>
        <h2>Exercice 2 : La classe abstraite Forme</h2>
        <%
            Forme[] formes = { new Cercle(5), new Carre(4) };
            for (Forme f : formes) {
        %>
            <p><%= f.toString() %> → Aire : <%= String.format("%.2f", f.aire()) %></p>
        <%
            }
        %>

        <%-- Exercice 3 : Interface Affichable --%>
        <h2>Exercice 3 : L'interface Affichable</h2>
        <%
            Affichable[] affichables = { chien, chat };
            for (Affichable af : affichables) {
                // On cast pour appeler getAffichage() qui simule afficher()
                if (af instanceof Chien) {
        %>
                    <p><%= ((Chien) af).getAffichage() %></p>
        <%
                } else if (af instanceof Chat) {
        %>
                    <p><%= ((Chat) af).getAffichage() %></p>
        <%
                }
            }
        %>

        <%-- Exercice 4 : Oiseau dans le tableau (déjà inclus dans animaux[]) --%>
        <h2>Exercice 4 : Ajouter un Oiseau</h2>
        <p>L'Oiseau "Titi" a été ajouté au tableau <code>Animal[]</code>.
           La boucle d'affichage n'a pas été modifiée — le polymorphisme fait le reste.</p>
        <%
            for (Animal a : animaux) {
        %>
            <p><%= a.crier() %></p>
        <%
            }
        %>

        <%-- Exercice 5 : instanceof --%>
        <h2>Exercice 5 : L'opérateur instanceof</h2>
        <%
            for (Animal a : animaux) {
                String type;
                if      (a instanceof Chien)  type = "C'est un chien";
                else if (a instanceof Chat)   type = "C'est un chat";
                else                          type = "Autre animal";
        %>
            <p><%= a.toString() %> → <%= type %></p>
        <%
            }
        %>

<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
