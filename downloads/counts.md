---
layout: default
title: counts
---

<h3>ADMB Distribution Download Counts</h3>
<table id="mytable">
{% for row in site.data.counts%}
<tr>
  <th>{{ row.Version }}</th>
  <th>{{ row.Date }}</th>
  <th>{{ row.Time }}</th>
  <th>{{ row.File_or_Group }}</th>
  <th>{{ row.Counts }}</th>
</tr>
{% endfor %}
</table>
