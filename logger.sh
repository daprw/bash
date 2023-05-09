#/bin/bash
#
# One-liner to test log filter, writes to std out.
# Will send message with email address, name, and other normal messages.
#
#
# regex pattern for most names: ^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$
# regex pattern for unicode names: ^([A-Za-z\u00C0-\u017F'\-]+)(\s[A-Za-z\u00C0-\u017F'\-]+)*(\s[A-Za-z\u00C0-\u017F'\-]+)?$
# regex pattern for most names part 2: \b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+
# regex pattern for most names part 3: ^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)
# regex pattern for emails RFC 5322: ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
while true; 
do 
  echo $(date) INFO: Transaction submitted by user email $(openssl rand -hex 12)@$(shuf -n1 -e gmail.com yahoo.com hotmail.com outlook.com aol.com protonmail.com icloud.com example.co.uk sample.org pinterest.co.uk ipinfo.io)
  sleep 1
  echo $(date) WARN: User2 has initiated protocol ORANGE
  sleep 2
done
