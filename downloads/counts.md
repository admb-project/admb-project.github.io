---
layout: default
title: counts
---

<table>
{% for date in site.data.counts%}
<tr>
  <th>{{ date.Version }}</th>
  <th>{{ date.Counts}}</th>
</tr>
{% endfor %}
</table>
