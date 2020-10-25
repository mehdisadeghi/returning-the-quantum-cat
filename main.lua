-- $Name:Returning the Quantum Cat$
-- $Name(ru):Возвращение квантового кота$
-- $Version: 1.6.1$
-- $Direction: auto

if stead.version < "1.5.3" then
	walk = _G["goto"]
	walkin = goin
	walkout = goout
	walkback = goback
end

require "xact"

gam_lang = {
	ru = 'Язык',
	en = 'English',
	fa = 'فارسی',
}

gam_title = {
	ru = 'Возвращение квантового кота',
	en = 'Returning the Quantum Cat',
	fa = 'نجات گربه‌ی کوانتومی',
}

if not LANG or not gam_lang[LANG] then
	LANG = "en"
end
--LANG = "fa"
gam_lang = gam_lang[LANG]
gam_title = gam_title[LANG]

main = room {
	nam = gam_title;
	forcedsc = true;
	dsc = txtc (
		txtb(gam_lang)..'^^'..
		img('gb.png')..' '..[[{en:English}^]]..
		img('ir.png')..' '..[[{fa:فارسی }^]]..
		img('ru.png')..' '..[[{ru:Русский}^]]
		);
	obj = {
		xact("en", code [[ gamefile('main-en.lua', true); return walk 'main' ]]);
		xact("fa", code [[ gamefile('main-fa.lua', true); return walk 'main' ]]);
		xact("ru", code [[ gamefile('main-ru.lua', true); return walk 'main' ]]);
	}
}

-- main = room {
-- 	nam = gam_title;
-- 	forcedsc = false;
-- 	dsc = txtc (
-- 		txtb(gam_lang)..'^^'..
-- 		img('gb.png')..' '..[[{fa:فارسی}^]]
-- 		);
-- 	obj = {
-- 		xact("fa", code [[ gamefile('main-fa.lua', true); return walk 'main' ]]);
-- 	}
-- }
