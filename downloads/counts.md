---
layout: default
title: counts
---

<h3>ADMB Download Counts</h3>
<table id="mytable">
<tr>
  <th>Version</th>
  <th>Date(YYY-MM-DD)</th>
  <th>Time(HST)</th>
  <th>File or Group</th>
  <th>Counts</th>
</tr>
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
