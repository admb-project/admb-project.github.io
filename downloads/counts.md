---
layout: default
title: counts
---

<h3>ADMB Distribution Download Counts</h3>
<table>
{% for date in site.data.counts%}
<tr>
  <th>{{ date.Version }}</th>
  <th>{{ date.Date }}</th>
  <th>{{ date.Time }}</th>
  <th>{{ date.File_or_Group }}</th>
  <th>{{ date.Counts }}</th>
</tr>
{% endfor %}
</table>
