# Utiliser Jinja 2

Moteur de template python utilisé par ansible.

## Instructions

Encadrées par {% %}. Exemple d'une boucle for:

     "hosts": [
        {% for item in hostsAdresses %}
            "{{ item }}",
        {% endfor %}
        "127.0.0.1"
      ],
      
## Filtres      

Sérialisation JSON et YAML:

    {{ some_variable | to_json }}
    {{ some_variable | to_yaml }}
    
    {{ some_variable | to_nice_json }}
    {{ some_variable | to_nice_yaml }}
    
Désérialisation JSON:

    tasks:
      - shell: cat /some/path/to/file.json
        register: result
    
      - set_fact: myvar="{{ result.stdout | from_json }}"     