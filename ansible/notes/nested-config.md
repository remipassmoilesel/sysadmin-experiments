# Nested loops

```
  - name: "debugs"
    debug:
      msg: "{{ item[0].name }} {{ item[1].name }}"
    with_nested:
      - "{{ bind.zones }}"
      - "{{ bind.reverse_zones }}"

```
