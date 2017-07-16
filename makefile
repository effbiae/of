all:
	m4 f| awk 'NF==1 && sub(/^@/,""){f=$$0; next} {print > f}'
	js-beautify -rj hm.js
	jshint hm.js
