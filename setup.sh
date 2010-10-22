set -e

# Do you have an account?
# Collect relevant information.
# POST it up.
# Explain any errors and exit.
# Populate ~/.token.
# Display a welcome message.

TMPNAME=$(mktemp devstructure-XXXXXXXXXX)
trap "rm -rf \"$TMPNAME\"" 0
echo "\033[1mWELCOME TO DEVSTRUCTURE\033[0m"
while true
do
	read -p "Do you already have an account? [yN] " YESNO
	[ -z "$YESNO" ] && YESNO="n"
	case "$YESNO" in

		y|Y)
			read -p "Email or login: " VALUE
			stty -echo
			read -p "Password: " PASSWORD
			echo
			stty echo
			case "$VALUE" in
				*@*) KEY="email";;
				*) KEY="login";;
			esac
			CODE=$(curl -s -w '%{http_code}\n' -o "$TMPNAME" \
				-d "$KEY"="$VALUE" \
				-d password="$PASSWORD" \
				"https://api.devstructure.com/sign_in")
			;;

		n|N)
			read -p "Email: " EMAIL
			read -p "Login: " LOGIN
			stty -echo
			read -p "Password: " PASSWORD
			echo
			read -p "Confirm password: " CONFIRM_PASSWORD
			echo
			stty echo
			[ "$PASSWORD" = "$CONFIRM_PASSWORD" ] || {
				echo "Please confirm your password." >&2
				continue
			}
			CODE=$(curl -s -w '%{http_code}\n' -o "$TMPNAME" \
				-d email="$EMAIL" \
				-d login="$LOGIN" \
				-d password="$PASSWORD" \
				"https://api.devstructure.com/sign_up")
			;;

		*) continue;;

	esac

	case "$CODE" in
		200) break;;
		400) echo "Invalid account credentials, please try again." >&2;;
		401) echo "Password doesn't match, please try again.">&2;;
		409) echo "That email or login is already registered." >&2;;
		*) echo "DevStructure is having problems." >&2;;
	esac

done
TOKEN=$(tr , \\n <"$TMPNAME" | tr -d \" | grep ^token | cut -c7-)
echo "TOKEN: $TOKEN"
#sudo touch /etc/token
#echo "$TOKEN" >~/.token
echo "You're good to go!"
# TODO More getting started material.

# Since this run has clearly been successful, there's no reason for this
# file to exist anymore.
#sudo rm $0
