all:
	m4 f| awk 'NF==1 && sub(/^@/,""){f=$$0; next} {print > f}'
	for x in kof.js hm.js;do js-beautify -rj $$x;jshint $$x;done
