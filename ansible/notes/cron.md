# Cron

Ajouter une tâche CRON (penser à la nommer pour ne pas qu'elle soit ajoutée systématiquement)

    - name: "Add cron task for image cleaning"
      cron:
        hour: "4"
        job: "/opt/image-cleaner/node_modules/image-cleaner/index.js &>> /var/log/docker-image-cleaning.log"
        name: docker-image-cleaning
        state: present
      become: yes