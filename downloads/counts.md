---
layout: default
title: counts
---

<h3>ADMB Distribution Download Counts</h3>
<table id="mytable">
{% for row in site.data.counts%}
<tr>
  <td>{{ row.Version }}</td>
  <td>{{ row.Date }}</td>
  <td>{{ row.Time }}</td>
  <td>{{ row.File_or_Group }}</td>
  <td>{{ row.Counts }}</td>
</tr>
{% endfor %}
</table>
