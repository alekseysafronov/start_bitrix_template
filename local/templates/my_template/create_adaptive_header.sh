#!/bin/bash

# Скрипт создания адаптивного хедера для Битрикс
# Запуск: ./create_adaptive_header.sh

cat > header.php << 'EOF'
<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) die();
?>

<header class="header">
    <div class="header__container">
        <!-- Логотип -->
        <div class="header__logo">
            <a href="/" class="logo-link">
                <img src="<?=SITE_TEMPLATE_PATH?>/images/logo.svg" alt="Логотип" class="logo">
                <span class="logo-text">Ваш Логотип</span>
            </a>
        </div>

        <!-- Основное меню -->
        <nav class="header__nav">
            <?$APPLICATION->IncludeComponent(
                "bitrix:menu", 
                "main_menu", 
                array(
                    "ROOT_MENU_TYPE" => "top",
                    "MAX_LEVEL" => 2,
                    "CHILD_MENU_TYPE" => "left",
                    "USE_EXT" => "Y",
                    "MENU_CACHE_TYPE" => "N",
                    "MENU_CACHE_TIME" => "3600",
                    "MENU_CACHE_USE_GROUPS" => "Y",
                    "MENU_CACHE_GET_VARS" => array(),
                ),
                false
            );?>
        </nav>

        <!-- Телефон -->
        <div class="header__phone">
            <a href="tel:+74951234567" class="phone-link">
                <span class="phone-prefix">+7 (495)</span>
                <span class="phone-number">123-45-67</span>
            </a>
        </div>

        <!-- Гамбургер для мобильных -->
        <button class="header__hamburger" aria-label="Открыть меню">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>

    <!-- Мобильное меню -->
    <div class="mobile-menu">
        <div class="mobile-menu__overlay"></div>
        <div class="mobile-menu__content">
            <button class="mobile-menu__close" aria-label="Закрыть меню">
                <span></span>
                <span></span>
            </button>
            
            <nav class="mobile-menu__nav">
                <?$APPLICATION->IncludeComponent(
                    "bitrix:menu", 
                    "mobile_menu", 
                    array(
                        "ROOT_MENU_TYPE" => "top",
                        "MAX_LEVEL" => 2,
                        "CHILD_MENU_TYPE" => "left",
                        "USE_EXT" => "Y",
                        "MENU_CACHE_TYPE" => "N",
                        "MENU_CACHE_TIME" => "3600",
                        "MENU_CACHE_USE_GROUPS" => "Y",
                    ),
                    false
                );?>
            </nav>

            <div class="mobile-menu__phone">
                <a href="tel:+74951234567" class="phone-link">
                    <span class="phone-prefix">+7 (495)</span>
                    <span class="phone-number">123-45-67</span>
                </a>
            </div>
        </div>
    </div>
</header>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const hamburger = document.querySelector('.header__hamburger');
    const mobileMenu = document.querySelector('.mobile-menu');
    const closeButton = document.querySelector('.mobile-menu__close');
    const overlay = document.querySelector('.mobile-menu__overlay');
    
    function openMenu() {
        mobileMenu.classList.add('active');
        document.body.style.overflow = 'hidden';
    }
    
    function closeMenu() {
        mobileMenu.classList.remove('active');
        document.body.style.overflow = '';
    }
    
    hamburger.addEventListener('click', openMenu);
    closeButton.addEventListener('click', closeMenu);
    overlay.addEventListener('click', closeMenu);
    
    // Закрытие по ESC
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeMenu();
        }
    });
    
    // Закрытие при клике на ссылку
    const mobileLinks = document.querySelectorAll('.mobile-menu__nav a');
    mobileLinks.forEach(link => {
        link.addEventListener('click', closeMenu);
    });
});
</script>
EOF

# Создаем CSS стили для хедера
cat > header.css << 'EOF'
/* Основные стили хедера */
.header {
    background: #ffffff;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    position: relative;
    z-index: 1000;
}

.header__container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    height: 80px;
}

/* Логотип */
.header__logo .logo-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #313131;
    font-weight: bold;
    font-size: 20px;
}

.header__logo .logo {
    height: 40px;
    margin-right: 10px;
}

.logo-text {
    color: #313131;
}

/* Основная навигация */
.header__nav {
    flex: 1;
    display: flex;
    justify-content: center;
}

/* Стили для меню Битрикс */
.header__nav ul {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 0;
    align-items: center;
}

.header__nav li {
    position: relative;
    margin: 0 15px;
}

.header__nav li a {
    color: #313131;
    text-decoration: none;
    font-size: 16px;
    font-weight: 500;
    padding: 10px 0;
    position: relative;
    transition: color 0.3s ease;
}

.header__nav li a:hover {
    color: #FF9600;
}

.header__nav li a::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 0;
    height: 2px;
    background: #FF9600;
    transition: width 0.3s ease;
}

.header__nav li a:hover::after {
    width: 100%;
}

/* Выпадающее меню */
.header__nav ul ul {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: #ffffff;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    min-width: 200px;
    flex-direction: column;
    z-index: 1001;
}

.header__nav li:hover > ul {
    display: flex;
}

.header__nav ul ul li {
    margin: 0;
    width: 100%;
}

.header__nav ul ul li a {
    display: block;
    padding: 12px 20px;
    border-bottom: 1px solid #f0f0f0;
    width: 100%;
    box-sizing: border-box;
}

.header__nav ul ul li:last-child a {
    border-bottom: none;
}

/* Телефон */
.header__phone .phone-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    font-weight: 600;
    font-size: 16px;
}

.phone-prefix {
    color: #FF9600;
}

.phone-number {
    color: #313131;
    margin-left: 2px;
}

/* Гамбургер */
.header__hamburger {
    display: none;
    flex-direction: column;
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px;
    width: 30px;
    height: 30px;
    justify-content: space-between;
}

.header__hamburger span {
    display: block;
    height: 3px;
    width: 100%;
    background: #313131;
    border-radius: 2px;
    transition: all 0.3s ease;
}

/* Мобильное меню */
.mobile-menu {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 2000;
}

.mobile-menu__overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    opacity: 0;
    transition: opacity 0.3s ease;
}

.mobile-menu__content {
    position: absolute;
    top: 0;
    right: -100%;
    width: 300px;
    height: 100%;
    background: #ffffff;
    transition: right 0.3s ease;
    padding: 80px 20px 40px;
    box-sizing: border-box;
    overflow-y: auto;
}

.mobile-menu__close {
    position: absolute;
    top: 20px;
    right: 20px;
    background: none;
    border: none;
    cursor: pointer;
    width: 30px;
    height: 30px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.mobile-menu__close span {
    display: block;
    height: 2px;
    width: 25px;
    background: #313131;
    position: absolute;
    top: 50%;
    left: 50%;
}

.mobile-menu__close span:first-child {
    transform: translate(-50%, -50%) rotate(45deg);
}

.mobile-menu__close span:last-child {
    transform: translate(-50%, -50%) rotate(-45deg);
}

.mobile-menu__nav ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.mobile-menu__nav li {
    margin-bottom: 10px;
}

.mobile-menu__nav li a {
    display: block;
    color: #313131;
    text-decoration: none;
    font-size: 18px;
    font-weight: 500;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
    transition: color 0.3s ease;
}

.mobile-menu__nav li a:hover {
    color: #FF9600;
}

.mobile-menu__nav ul ul {
    margin-left: 15px;
    display: none;
}

.mobile-menu__nav li.active > ul {
    display: block;
}

.mobile-menu__phone {
    margin-top: 30px;
    text-align: center;
}

.mobile-menu__phone .phone-link {
    font-size: 18px;
    font-weight: 600;
}

/* Активное состояние мобильного меню */
.mobile-menu.active {
    display: block;
}

.mobile-menu.active .mobile-menu__overlay {
    opacity: 1;
}

.mobile-menu.active .mobile-menu__content {
    right: 0;
}

/* Адаптивность */
@media (max-width: 1024px) {
    .header__nav {
        display: none;
    }
    
    .header__phone {
        display: none;
    }
    
    .header__hamburger {
        display: flex;
    }
    
    .mobile-menu {
        display: block;
    }
}

@media (max-width: 768px) {
    .header__container {
        height: 70px;
        padding: 0 15px;
    }
    
    .header__logo .logo-text {
        font-size: 18px;
    }
    
    .mobile-menu__content {
        width: 280px;
    }
}

@media (max-width: 480px) {
    .header__container {
        height: 60px;
    }
    
    .header__logo .logo {
        height: 30px;
    }
    
    .header__logo .logo-text {
        font-size: 16px;
    }
    
    .mobile-menu__content {
        width: 100%;
        padding: 60px 15px 30px;
    }
}
EOF

# Создаем папку для изображений и добавляем заглушку для логотипа
mkdir -p images

# Создаем простой SVG логотип как заглушку
cat > images/logo.svg << 'EOF'
<svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
    <rect width="40" height="40" rx="8" fill="#FF9600"/>
    <text x="20" y="25" text-anchor="middle" fill="white" font-family="Arial" font-size="16" font-weight="bold">L</text>
</svg>
EOF

# Создаем файл для обновления основного styles.css
cat > update_styles.css << 'EOF'
/* Добавьте эти стили в ваш основной styles.css */

/* Импорт стилей хедера */
@import url('header.css');

/* Дополнительные глобальные стили */
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 0;
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
    color: #313131;
}

main {
    min-height: calc(100vh - 80px);
    padding: 20px;
}

/* Анимации */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideIn {
    from { transform: translateX(100%); }
    to { transform: translateX(0); }
}

/* Утилиты */
.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}
EOF

echo "✅ Адаптивный хедер успешно создан!"
echo "📁 Созданные файлы:"
echo "   - header.php (основной файл хедера)"
echo "   - header.css (стили хедера)" 
echo "   - images/logo.svg (логотип-заглушка)"
echo "   - update_styles.css (дополнительные стили для добавления в основной файл)"
echo ""
echo "📋 Что нужно сделать дальше:"
echo "   1. Добавьте @import url('header.css'); в начало вашего styles.css"
echo "   2. Убедитесь, что компонент меню настроен в Битрикс"
echo "   3. Настройте нужный номер телефона в header.php"
echo "   4. Замените logo.svg на ваш настоящий логотип"