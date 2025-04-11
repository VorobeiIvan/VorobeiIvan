#!/bin/bash

# Отримуємо всі репозиторії через GitHub API
repos=$(curl -s "https://api.github.com/users/VorobeiIvan/repos" | jq -r '.[].name')

# Ініціалізуємо змінну для оновлення README
readme_content="### 📦 Репозиторії:\n"

# Перебираємо всі репозиторії
for repo in $repos; do
  echo "Fetching details for $repo"
  
  # Отримуємо вміст репозиторію
  repo_data=$(curl -s "https://api.github.com/repos/VorobeiIvan/$repo/contents")
  
  # Шукаємо файли залежностей
  for file in $(echo "$repo_data" | jq -r '.[].name'); do
    if [[ "$file" == "package.json" ]]; then
      # Якщо є package.json, то додаємо фреймворки та бібліотеки
      tech_stack="JavaScript, React, Redux"
      readme_content+="\n- **[$repo](https://github.com/VorobeiIvan/$repo)**\n  - **Мови:** JavaScript\n  - **Фреймворки:** React, Redux\n"
    fi
  done
done

# Оновлюємо README.md
echo -e "$readme_content" > README.md
