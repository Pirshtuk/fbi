curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/violent-crime/offense/count?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'

curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/violent-crime/offender/count?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'

curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/violent-crime/victim/count?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'

curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/violent-crime/offense/age?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'

curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/all/offense/age?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'

curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/aggravated-assult/offense/age?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'

curl -X 'GET' \
  'https://api.usa.gov/crime/fbi/cde/nibrs/agency/CA0160000/property-crime/offense/age?from=1985&to=2022&API_KEY=iiHnOKfno2Mgkt5AynpvPpUQTEyxE77jo1RU8PIv' \
  -H 'accept: application/json'
