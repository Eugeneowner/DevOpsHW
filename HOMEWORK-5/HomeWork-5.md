# Exercise 1:
#!/bin/bash
echo "Hello, World!"

# Exercise 2:
#!/bin/bash
read -p "Enter your name: " name
echo "Hello, $name"

Exercise 3:
#!/bin/bash
read -p "Enter the file name: " filename

if [ -f "$filename" ]; then
  echo "You requested an existing file: '$filename'"
else
  echo "You requested a file that does not exist: '$filename'"
fi

# Exercise 4:
#!/bin/bash
for number in {1..10}; do
  echo $number
done

# Exercise 5:
#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ${file_path} source_file destination_file"
    exit 1
fi

SOURCE_FILE="$1"
DESTINATION_FILE="$2"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file '$SOURCE_FILE' does not exist."
    exit 2
fi

cp "$SOURCE_FILE" "$DESTINATION_FILE"

if [ "$?" -eq 0 ]; then
    echo "File copied successfully from '$SOURCE_FILE' to '$DESTINATION_FILE'."
else
    echo "Error: File copy failed."
    exit 3
fi

# Exercise 6:
#!/bin/bash

file_path="/path/to/your/file"

echo "Enter a sentence:"
read -r user_input

if [ -z "$user_input" ]; then
    echo "Error: No input provided. Please enter a sentence." > "$file_path"
    exit 1
fi

reversed_sentence=$(echo "$user_input" | awk '{for(i=NF; i>0; i--) printf "%s ", $i; print ""}')

echo "Reversed sentence: $reversed_sentence" > "$file_path"


# Exercise 7:
#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

file_path=$1

if [ ! -f "$file_path" ]; then
  echo "Error: File '$file_path' does not exist or is not a regular file."
  exit 1
fi

if [ ! -r "$file_path" ]; then
  echo "Error: File '$file_path' is not readable."
  exit 1
fi

line_count=$(wc -l < "$file_path")

echo "The file '$file_path' contains $line_count lines."

# Exercise 8:
#!/bin/bash
fruits=("pineapple" "apple" "elderberry" "banana" "cherry" "raspberry" "orange")
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done


# Exercise 9:
#!/bin/bash
if [ -z "$1" ]; then
  echo "Error: No file path provided. Usage: $0 <file_path>"
  exit 1
fi

file_path="$1"

if [ -e "$file_path" ]; then
  echo "File exists. Displaying contents:"
  echo "-----------------------------------"
  cat "$file_path"
  echo "\n-----------------------------------"
else
  echo "Error: File '$file_path' does not exist."
  exit 1
fi

# Systemd service

Write script which watching directory "~/watch". If it sees that there appeared a new file, it prints files content and rename it to *.back

Write SystemD service for this script and make it running

#!/bin/bash
WATCH_DIR=~/watch
mkdir -p "$WATCH_DIR"
inotifywait -m -e create "$WATCH_DIR" | while read -r directory events filename;
do
if [I -f $WATCH_DIR/$filename" ]l; then
echo "Новый файл обнаружен: $filename"
echo
"Содержимое файла:"
cat "$WATCH_DIR/$filename"
mv "$WATCH_DIR/$filename" "$WATCH_DIR/$filename.back"
echo
"Файл переименован в $filename.back"
fi
done

Создайем файл для службы:

[Unit]
Description=Scan watch folder for new files
After=network.target
[Service]
ExecStart=/root/watch/watch_dir.sh
WorkingDirectory=/root/watch
Restart=on-failure
User=root
Group=root
StandardOutput=journal 
StandardError=journal
[Install]
WantedBy=multi-user.target

Перезагружаем SystemD для применения изменений

sudo systemctl daemon-reload

Запусткаем сервис:
sudo systemctl start watchdir.service

Проверяем, что сервис работает:
sudo systemctl status watchdir.service

Проверка журнала SystemD:
journalctl -u watchdir.service -f










### Bash scripting

Exercise 1: Hello World
Write a Bash script that simply echoes "Hello, World!" when executed.

Exercise 2: User Input
Create a script that asks the user for their name and then greets them using that name.

Exercise 3: Conditional Statements
Write a script that checks if a file exists in the current directory. If it does, print a message saying it exists; otherwise, print a message saying it doesn't exist.

Exercise 4: Looping
Create a script that uses a loop to print numbers from 1 to 10.

Exercise 5: File Operations
Write a script that copies a file from one location to another. Both localtions should be passed as arguments

Exercise 6: String Manipulation
Build a script that takes a user's input as a sentence and then reverses the sentence word by word (e.g., "Hello World" becomes "World Hello").

Exercise 7: Command Line Arguments
Develop a script that accepts a filename as a command line argument and prints the number of lines in that file.

Exercise 8: Arrays
Write a script that uses an array to store a list of fruits. Loop through the array and print each fruit on a separate line.

Exercise 9: Error Handling
Develop a script that attempts to read a file and handles errors gracefully. If the file exists, it should print its contents; if not, it should display an error message.


### Systemd service

Write script which watching directory "~/watch". If it sees that there appeared a new file, it prints files content and rename it to *.back

Write SystemD service for this script and make it running

Перейдіть за посиланням та виконайте завдання:
https://drive.google.com/file/d/1iCOK_XrpnaERSqX1zooFdG5g6e0tpzhb/view?usp=drive_link

Будь ласка, додайте скріншоти отриманих результатів, щоб ми могли відстежувати ваш прогрес і консультувати вас.


Вариант cкрипта через while. 

#!/bin/bash

# Первая переменная для параметров — директория для наблюдения.
WATCH_DIR=${1:-~/watch}

# Вторая переменная для параметров —  для добавления суффикс .back.
SUFFIX=${2:-.back}

# Проверяем, что такая директория существует.
mkdir -p "$WATCH_DIR"

echo "Запущен мониторинг директории: $WATCH_DIR, файлы будут переименовываться с добавлением суффикса '$SUFFIX'."

while true; do
    for filename in "$WATCH_DIR"/*; do
        if [[ -f "$filename" && ! "$filename" =~ $SUFFIX$ ]]; then
            echo "Новый файл обнаружен: $(basename "$filename")"
            echo "Содержимое файла:"
            cat "$filename"
            mv "$filename" "$filename$SUFFIX"
            echo "Файл переименован в $(basename "$filename")$SUFFIX"
        fi
    done
  sleep 2
done