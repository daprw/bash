# cors_header_cf.sh

I found that there wasn't a native way to add CORS header to multiple containers. While running the curl command against one or even a few containers is not a major concern, if someone has thousands of containers this can become tedious. 

The script simplifies this by allowing the user to generate an auth token to the identity api endpoint and loop through all the containers in the specified region to enable CORS header
