#!/bin/bash

# Скрипт создания минимального шаблона для Битрикс
# Запуск: ./create_bitrix_template.sh

TEMPLATE_NAME="my_template"
CURRENT_DIR=$(pwd)

echo "Создание минимального шаблона для Битрикс в текущей папке: $CURRENT_DIR"

# Создаем структуру папок
mkdir -p local/templates/$TEMPLATE_NAME

# Переходим в папку шаблона
cd local/templates/$TEMPLATE_NAME

# 1. Создаем description.php
cat > description.php << 'EOF'
<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) die();

$arTemplate = array(
    "NAME" => "Мой минимальный шаблон",
    "DESCRIPTION" => "Минимальный шаблон для Битрикс",
    "SORT" => 100,
    "TYPE" => "",
);
?>
EOF

# 2. Создаем template.php
cat > template.php << 'EOF'
<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) die();

$this->setFrameMode(true);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <?
    $APPLICATION->ShowHead();
    $APPLICATION->ShowCSS();
    ?>
    <title><?$APPLICATION->ShowTitle()?></title>
</head>
<body>
    <div id="panel"><?$APPLICATION->ShowPanel()?></div>
    
    <!-- Header -->
    <?$APPLICATION->IncludeComponent(
        "bitrix:main.include",
        "",
        array(
            "AREA_FILE_SHOW" => "file",
            "PATH" => SITE_TEMPLATE_PATH . "/header.php"
        )
    );?>
    
    <!-- Main content -->
    <main>
        <?$APPLICATION->IncludeComponent(
            "bitrix:main.include",
            "",
            array(
                "AREA_FILE_SHOW" => "file",
                "PATH" => $APPLICATION->GetCurPage() 
            )
        );?>
    </main>
    
    <!-- Footer -->
    <?$APPLICATION->IncludeComponent(
        "bitrix:main.include",
        "",
        array(
            "AREA_FILE_SHOW" => "file",
            "PATH" => SITE_TEMPLATE_PATH . "/footer.php"
        )
    );?>
</body>
</html>
EOF

# 3. Создаем header.php
cat > header.php << 'EOF'
<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) die();
?>

<header>
    <h1>Мой сайт</h1>
    <nav>
        <?$APPLICATION->IncludeComponent(
            "bitrix:menu",
            "top",
            array(
                "ROOT_MENU_TYPE" => "top",
                "MAX_LEVEL" => 1,
                "CHILD_MENU_TYPE" => "left",
                "USE_EXT" => "N",
                "MENU_CACHE_TYPE" => "N",
                "MENU_CACHE_TIME" => "3600",
                "MENU_CACHE_USE_GROUPS" => "Y",
                "MENU_CACHE_GET_VARS" => ""
            )
        );?>
    </nav>
</header>
EOF

# 4. Создаем footer.php
cat > footer.php << 'EOF'
<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) die();
?>

<footer>
    <p>&copy; <?=date('Y')?> Мой сайт. Все права защищены.</p>
</footer>
EOF

# 5. Создаем styles.css
cat > styles.css << 'EOF'
/* Минимальные стили для шаблона */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    line-height: 1.6;
}

header {
    background: #f4f4f4;
    padding: 20px;
    text-align: center;
}

nav ul {
    list-style: none;
    padding: 0;
}

nav ul li {
    display: inline;
    margin: 0 10px;
}

main {
    padding: 20px;
    min-height: 400px;
}

footer {
    background: #333;
    color: white;
    text-align: center;
    padding: 10px;
    position: relative;
    bottom: 0;
    width: 100%;
}

#panel {
    background: #ffeb3b;
    padding: 5px;
    text-align: center;
}
EOF

# Возвращаемся в исходную директорию
cd "$CURRENT_DIR"

# Делаем скрипт исполняемым (если это сам скрипт)
if [[ "$0" == *".sh" ]]; then
    chmod +x "$0"
fi

echo "✅ Шаблон '$TEMPLATE_NAME' успешно создан!"
echo "📍 Расположение: local/templates/$TEMPLATE_NAME"
echo ""
echo "Структура созданных файлов:"
find local/templates/$TEMPLATE_NAME -type f -print | sort