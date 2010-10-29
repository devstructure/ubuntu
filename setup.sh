# Setup DevStructure.

# Gather credentials.
TMPNAME=$(mktemp devstructure-XXXXXXXXXX)
echo
echo -e "\033[1mGET STARTED WITH DEVSTRUCTURE\033[0m"
echo
while true
do
	read -p "Do you have an account? (yes/no/skip) " YESNO
	[ -z "$YESNO" ] && YESNO="n"
	case "$YESNO" in

		# Sign in.
		yes|y|Y)
			read -p "Email or login: " VALUE
			stty -echo
			read -p "Password: " PASSWORD
			echo
			stty echo
			case "$VALUE" in
				*@*) KEY="email";;
				*) KEY="login";;
			esac
			CODE="$(curl -s -w '%{http_code}\n' -o "$TMPNAME" \
				-d "$KEY"="$VALUE" \
				-d password="$PASSWORD" \
				"https://api.devstructure.com/sign_in" || echo -)";;

		# Sign up.
		no|n|N)
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
			CODE="$(curl -s -w '%{http_code}\n' -o "$TMPNAME" \
				-d email="$EMAIL" \
				-d login="$LOGIN" \
				-d password="$PASSWORD" \
				"https://api.devstructure.com/sign_up" || echo -)";;

		# Skip setup for now.
		skip|s|S)
			echo "Skipping DevStructure setup for now."
			break;;

		# Ask again.
		*) continue;;

	esac

	# Successful sign in or sign up breaks out of the loop.  Everyone
	# else gets a message and heads back to the top.
	case "$CODE" in
		200) ;;
		400)
			echo "Invalid account credentials, please try again." >&2
			continue;;
		401)
			echo "Password doesn't match, please try again.">&2
			continue;;
		409)
			echo "That email or login is already registered." >&2
			continue;;
		-)
			echo "Please try again when you're connected to the Internet." >&2
			echo "  sh /etc/profile.d/setup.sh" >&2
			break;;
		*)
			echo "DevStructure is having problems." >&2
			continue;;
	esac

	# Parse out the DevStructure API token.
	TOKEN=$(tr , \\n <"$TMPNAME" | tr -d \" | grep ^token | cut -c7-)
	[ -z "$TOKEN" ] && {
		echo "No DevStructure API token found." >&2
		echo -e \
			"Please contact us at \033[4msupport@devstructure.com\033[0m." >&2
		break
	}

	# Store the DevStructure API token for later.
	echo "$TOKEN" >~/.token

	# Install the DevStructure software.
	echo
	echo "One moment while we upgrade the DevStructure packages..."
	echo
	sudo apt-get update
	sudo apt-get -y install sandbox blueprint

	# Now the complete welcome message.
	echo
	echo -e "\033[1mWELCOME TO DEVSTRUCTURE\033[0m"
	echo
	echo -e "Get started by creating a sandbox: " \
		"\033[4msandbox create my-first-sandbox\033[0m"
	echo
	echo -e "Work there to keep your server clean: " \
		"\033[4msandbox use my-first-sandbox\033[0m"
	echo
	echo -e "And when you're ready to deploy: " \
		"\033[4mblueprint create my-first-blueprint\033[0m"
	echo
	echo -e "Learn more at \033[4mhttp://docs.devstructure.com/start\033[0m"

	# This run was successful so setup.sh is no longer necessary.
	sudo rm /etc/profile.d/setup.sh

	break
done

rm -f "$TMPNAME"
