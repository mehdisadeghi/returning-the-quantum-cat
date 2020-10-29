mywear = obj {
	nam = 'کاپشن',
	dsc = function(s)
		if here() == stolcorridor then	
			local st='.';
			if not have('gun') then
				st = ', شاتگانم زیرشه';
			end
			return 'در ضمن {کاپشن} خلبانیم رو جالباسیه'..st;
		else
			return 
			'{کاپشنم} از میخ روی در چوب کاج آویزونه.';
		end
	end,
	inv = 'زمستونه. من یه کاپشن خلبانی گرم تنمه.',
	tak = function(s)
		if here() == stolcorridor then
			if have('alienwear') then
				return 'من لباسامو پوشیدم... اگه کاپشنم رو هم بردارم مشکوک به نظر می‌رسم...', false;
			end
			if me()._walked then
				me()._walked = false;
				inv():add('gun');
				return 'هیچی کاپشن خلبانی من نمی‌شه!';
			end
			return 'اونطوری خیلی تابلو می‌شه... ', false;
		else
			return 'کتمو از رو آویز برداشتم.';
		end
	end, 
	use = function(s, o)
		if o == 'guy' then
			return 'بعد یه مکث کوتاه کاپشن‌ها رو عوض کردین...';
		end
	end
};

money = obj {
	nam = 'پول',
	inv = 'پول گنده نکبته... همون بهتر که من پول چندانی ندارم...',
	use = function(s, w)
		if w == 'shopman' then
			if shopman._wantmoney then
				shopman._wantmoney = false;
				return 'پول ولادیمیر رو دادم.';
			end
			return 'نمی‌خوام همینطوری پول بودم...';
		end
	end
};

mybed = obj {
	nam = 'bed',
	dsc = 'کنار پنجره یه {تخته}.',
	act = 'وقتی برای خواب نیست.',
};

mytable = obj {
	nam = 'میز',
	dsc = 'یه {میز} بلوط کشودار گوشه‌ی سمت چپه.',
	act = function()
		if not have(money) then
			take('money');
			return 'بعد زیر و رو کردن کشو، پول پیدا کردم.';
		end
		return 'میز... خودم ساختمش.';
	end,
};

foto = obj {
	nam = 'عکس',
	dsc = 'یه {عکس} قاب شده روی میزه.',
	tak = 'عکس رو برداشتم.',
	inv = 'عکس من و باریسکه.',
};

gun = obj {
	nam = 'شاتگان',
	dsc = 'گوشه‌ی راست کابین یه {شاتگانه}.',
	tak = 'شاتگان رو برداشتم و انداختم پشتم.',
	inv = function(s)
		local st = '';
		if s._obrez then
			st = ' راستی! الان اون یه نصفه شاتگانه.';
			if s._hidden then
				st = st..' تو لباسم قایمش کردم.';
			end
		end
		if s._loaded then
			return 'شاتگان پره...'..st;
		else	
			return 'شاتگان خالیه... به ندرت تو جنگل ازش استفاده کردم...'..st;
		end
	end,
	use = function(s, w)
		if not s._hidden then
			if w == 'mywear' or w == 'alienwear' then
				if not s._obrez then
					return 'سعی کردم شاتگان رو تو لباسم قایم کنم ولی خیلی بزرگ بود..'
				else
					s._hidden = true;
					return 'الان دیگه می‌تونم شاتگان برش خورده رو تو لباسم قایم کنم!';
				end
			end
		end
		if not s._loaded then
			return 'خالیه...', false;
		end
		if w == 'guard' then
			return 'آره، اونا عوضی‌ان، اما عوضی‌ها هم آدمن. از این گذشته کمکی هم نمی‌کنه...', false;
		end
		if w == 'wire' then
			return 'خیلی نزدیکه... یه چیزی مثل سیمچین لازم دارم...', false;
		end
		if w == 'cam' and not cam._broken then
			cam._broken = true;
			s._loaded = false;
			return 'دوربین رو نشونه گرفتم و هر دو لول رو خالی کردم روش... انعکاس صدای شلیک توی زوزه‌ی طوفان برف محو شد...';
		end
		if w == 'mycat' or w == 'shopman' or w == 'guy' then
			return 'فکر من این نبود...', false;
		end
	end
};

fireplace = obj {
	nam = 'شومینه',	
	dsc = 'یه {شومینه} سینه‌ی دیواره. شعله‌های لرزون آتیش اتاق رو روشن کردن.',
	act = 'دوست دارم عصرهای طولانی زمستون رو کنار شومینه بگذرونم.',
};

mycat = obj {
	nam = 'باریسک',
	_lflast = 0,
	lf = {
		[1] = 'باریسک داره تو بغلم جابجا می‌شه.',
		[2] = 'باریسک از بغلم داره سرک می‌کشه.',
		[3] = 'باریسک تو بغلم خرخر می‌کنه.',
		[4] = 'باریسک تو بغلم می‌لرزه.',
		[5] = 'گرمای باریسک رو تو بغلم حس می‌کنم.',
		[6] = 'باریسک از تو بغلم خم می‌شه بیرون و اطراف رو نگاه می‌کنه.',
	},
	life = function(s)
		local r = rnd(6);
		if r > 2 then
			return;
		end 
		r = rnd(6);
		while (s._lflast == r) do
			r = rnd(6);
		end
		s._lflast = r;
		return s.lf[r];
	end,
	desc = { [1] = 'گربه‌ی قشنگم کنار شومینه خودشو خیلی جون جونی لوله کرده و خوابیده. اسمش {باریسکه}، یعنی «پلنگ برفی کوچیک».',
		 [2] = '{باریسک} داره محوطه اطراف کلبه رو چک می‌کنه.',
		 [3] = '{باریسک} نشسته رو صندلی جلو.',
		 [4] = '{باریسک} داره یه چیزی رو توی آشغالا با دقت وارسی می‌کنه...',
		 [5] = '{باریسک} جستی می‌پره رو پاهای من',
	},
	inv = 'باریسک بغلمه... پیشی کوچولوی من... هم تو رو نجات می دم هم همه دنیا رو!!!',
	dsc = function(s)
		local state
		if here() == home then
			state = 1;
		elseif here() == forest then
			state = 2;
		elseif here() == inmycar then
			state = 3;
		elseif here() == village then
			state = 4;
		elseif here() == escape3 then
			state = 5;
		end
		return s.desc[state];
	end,
	act = function(s)
		if here() == escape3 then
			take('mycat');
			lifeon('mycat');
			return 'باریسک رو جا دادم بغلم.';
		end
		return 'پشت گوش باریسک رو خاروندم...';
	end,
};

inmycar = room {
	nam = 'توی ماشین',
	dsc = 'توی ماشینم هستم... رخش پرقدرت من...',
	pic = 'gfx/incar.png',
	way = {'forest', 'village'},
	enter = function(s, f)
		local s = 'در ماشین رو باز می‌کنم.';
		if have('mybox') then
			return 'با این جعبه نمی‌تونم بشینم تو ماشین...', false;
		end
		if seen('mycat') then
			s = s..' باریسک می‌پره تو ماشینم.'
			move('mycat','inmycar');
		elseif not me()._know_where then
			return 'نه... اول باید باریسک رو پیدا کنم!', false
		end
		if f == 'guarddlg' then
			return 'عجب... باید یه راهی پیدا کنم...';
		end
		return cat(s, ' خب، دیگه وقت رفتنه...');
	end,
	exit = function(s, t)
		local s=''
		if seen('mycat') then
			s = ' اولین چیزی که از ماشین بیرون می‌پره باریسکه.';
			move('mycat',t);
		end
		if ref(t) ~= from() then
			from().obj:del('mycar');
			move('mycar', t);
			return [[
ماشین به راحتی روشن می‌شه... بعد یه مسیر طولانی بالاخره موتور رو خاموش می‌کنم و در رو باز می‌کنم...]]..s;
		end
		return 'نه... فکر کنم چیزی رو فراموش کردم...'..s;
	end
};

mycar = obj {
	nam = 'my car',
	desc = {
	[1] = 'تویوتا {پیکاپ} قدیمیم جلوی در کابینه.',
	[2] = 'تویوتا {پیکاپ} قدیمیم توی پارکینگه.',
	[3] = '{پیکاپ} من نزدیک اتاقک نگهبانیه.',
	[4] = '{پیکاپ} من سر نبشه.',
	},
	dsc = function(s)
		local state
		if here() == forest then
			state = 1;
		elseif here() == village then
			state = 2;
		elseif here() == inst then
			state = 3;
		elseif here() == backwall then
			state = 4;
		end
		return s.desc[state];
	end,
	act = function(s)
		return walk('inmycar');
	end
};

iso = obj {
	nam = 'نوارچسب عایق',
	inv = 'یه حلقه چسب عایق آبی...',
	use = function(s, o)
		if o == 'trap' and not trap._iso then
			trap._iso = true;
			return 'تله رو با چسب عایق‌کاری کردم.';
		end
		if o == 'wire' then
			return 'چرا? من توی سیم‌خاردار نمی‌رم. در ضمن من نمی‌تونم عایق‌کاریش بکنم، برق منو می‌گیره!';
		end
	end
};

trap = obj {
	nam = 'تله',
	dsc = 'یه {تله فلزی} توی برفه.', -- !!!!
	tak = 'شکارچی‌های غیرقانونی لعنتی! تله‌ها رو با خودم می‌برم.',
	inv = function(s)
		if s._salo then
			return 'تله‌ی موش بزرگ! عایق‌کاری شد.';
		end
		if s._iso then
			return 'استیله. و خیلی تیز. عایق‌کاری هم شده.';
		else
			return 'استیله. و خیلی تیز.';
		end
	end,
	use = function(s, o)
		if o == 'wire' and not wire._broken then 
			if not s._iso then
				return 'تله از فلزه... برق منو می‌گیره و ختم ماجرا...';
			end
			wire._broken = true;
			onwall.way:add('eside');
			return 'تله ساده رو میارم سر سیم خاردار... آخه فکر کردم که تله ممکنه سیم‌خاردار رو قطع بکنه!';
		end
	end
};

deepforest = room {
	i = 0,
	nam = 'جنگل انبوه',
	pic = 'gfx/deepforest.png',
	dsc = function(s)
		local st = 'تو دل جنگلم... ';
		if s._i == 1 then
			return st..'کاج و سرخس... و دیگر هیچ...';
		elseif s._i == 2 then
			return st..'درخت‌های توس زیبا — سعی می‌کنم گم نشم...';
		elseif s._i == 3 then
			return st..'بیشه‌ی غیرقابل رسوخ... سردرنمیارم. یعنی گم شدم؟..';
		elseif s._i == 4 then
			return st..'یه دریاجه زیبا... آره... باید برگردم؟';
		elseif s._i == 5 then
			s._trap = true;
			return st..'مقدار بته... بازم بته... و بازهم بته...';
		else
			return st..'کنده درخت... چه کنده درخت قشنگی...';
		end
	end, 
	enter = function(s,f)
		if f == 'forest' then
			s._trap = false;
		end
		s._lasti = s._i;
		while (s._i == s._lasti) do
			s._i = rnd(6);
		end
		s.obj:del('trap');
		s.way:del('forest');
		if s._i == 5 and not inv():srch('trap') then
			s.obj:add('trap');
		end
		if s._i == 3 and s._trap then
			s.way:add('forest');
		end
		if f == 'forest' and inv():srch('trap') then
			return [[مرسی, من قبلا یه چرخی تو جنگل زدم...]], false;
		end
		if f == 'deepforest' then
			return 'عجب... بذار ببینم...';
		end
		return [[به طرف جنگل، اونم پای پیاده؟
خب... چرا که نه — هرچی نباشه شغلم اینه... حداقل باثت پریدن چند تا شکارچی غیرقانونی می‌شم...]], true;
--Я пол часа бродил по лесу, когда наткнулся на капкан...
--Проклятые браконьеры! Я взял капкан с собой.]], false;
	end,
	way = {'deepforest'},
};

road = room {
	nam = 'جاده',
	enter = function()
		return 'پیاده؟ نععع...', false;
	end
};

forest = room {
	nam = 'جلوی کلبه',
	pic = 'gfx/forest.png',
	dsc = [[
	جلوی کلبه روی همه چیز رو امواجی از برف گرفته. راه شهر پوشیده از برفه. اطراف کاپین جنگل وحشیه. جاده شهر هم پوشیده از برفه.]],
	way = { 'home', 'deepforest', 'road' },
	obj = { 'mycar' },
};

home = room {
	nam = 'کلبه',
	pic = function(s)
		if not seen('mycat') then
			return "gfx/house-empty.png"
		end
		return "gfx/house.png";
	end,
	dsc = [[
	من ده سال تو این کلبه گذروندم. ده سال پیش خودم ساختمش. کمی کوچیکه، ولی دنجه.
	]],
	obj = { 'fireplace', 'mytable', 'foto', 'mycat', 'gun', 
	vobj(1,'window', 'کلبه یه تک {پنجره} داره.'), 
	'mybed', 'mywear' },
	way = { 'forest' },
	act = function(s,o)
		if o == 1 then
			return 'بیرون همه چی یه دست سفیده...';
		end
	end,
	exit = function()
		if not have('mywear') then
			return 'بیرون سرده...بدون کاپشن خلبانیم عمرا بیرون برم.', false
		end
		if seen(mycat) then
			move('mycat','forest');
			return [[
			وقتی داشتم بیرون می‌رفتم، باریسک یهو بیدار شد و افتاد دنبالم. پشت گوشهاش نوازشش کردم. «با من میای»؟
]]
		end
	end
};
---------------- here village begins
truck = obj {
	nam = 'ماشین سیاه',
	dsc = 'یه {ماشین} سیاه با شیشه‌های دودی جلوی مغازه است.',
	act = 'عجب... یه ونه... بدنه تقویت شده، از روی فرورفتگی لاستیک‌ها می‌شه فهمید...',
};

guydlg = dlg {
	pic = 'gfx/guy.png',
	nam = 'گفتگو با کارتن‌خواب',
	dsc = 'رفتم طرفش... برگشت و نگاهم کرد — یه مرد قدکوتاه با یه کلاه کهنه و یه کت پاره پوره.',
	obj = {
		[1] = phr('سلام! سرده مگه نه؟', 'آره... یه جورایی...'),
		[2] = phr('چی شد سر از خیابونا درآوردی؟', 
[[یه زمانی دنبال گرفتن دکترام بودم...داشتم تزم رو در مورد ساختار ماده می‌نوشتم... اما...خیلی به مخم فشار آوردم... و سعی کردم آروم بگیرم... و حالا اینجام...]]),
		[3] = phr('اسمت چیه؟', 'ادوارد...'),
		[4] = _phr('وقتی که ترکت کردم، یه ماشین کنارت بود... الان کجاست؟', 'عجب...', 'pon(5)'),
		[5] = _phr('آره... یه گربه نر. یه گربه نر معمولی که داره دور رو بر آشغال‌ها پرسه می‌زنه.', 'پس اون گربه‌ی تو بود؟ عجب...', 'pon(6)');
		[6] = _phr('آره... اون باریسک من بود! بگو بگو!', 
'... اوهوم... فکر کنم اون مرد گرفتش... اوهوم... — استخونهام تیر کشید...', 'pon(7)'),
		[7] = _phr('کجا، کجا رفت؟', 'شرمنده داداش، ندیدم...', 'shopdlg:pon(4); pon(8);'),
		[8] = phr('باشه... خوش باشی...', '...', 'pon(8); back()'),
	},
	exit = function()
		pon(1);
		return 'برگشت و رفت سروقت گشتن سطل‌های زباله...';
	end
};

guy = obj {
	nam = 'کارتن‌خواب',
	dsc = 'یه {کارتن‌خواب} داره تو سطل‌های زباله رو می‌گرده.',
	act = function()
		return walk('guydlg');
	end,
	used = function(s, w)
		if w == 'money' then
			return [[
رفتم طرفش رو یه کم پول بهش تعارف زدم... گفت: «من به پول بقیه نیازی ندارم».]];
		else
			return 'به چه دردش می‌خوره؟';
		end
	end,
};

nomoney = function()
	pon(1,2,3,4,5);
	shopdlg:pon(2);
	return cat('اینجا بود که یادم اومد من اصلا پولی ندارم... حتی یه قرون...^',back());
end

ifmoney ='if not have("money") then return nomoney(); end; shopman._wantmoney = true; ';

dshells = obj {
	nam = 'پوکه',
	dsc = function(s)
		-- Note for translators: 
		-- this block picks the appropriate plural form 
		-- for “shells” for a given numeral. Since English has 
		-- only 1 form, I commented it out. 
		-- Uncomment and use form-number combinations
		-- appropriate for your language 
		if here()._dshells > 1 then
			return 'زیر پاهام یه {پوکه فشنگ} افتاده...';
		else 
			return 'زیر پاهام '..here()._dshells..' تا {پوکه فشنگ} افتاده...';
			-- return 'Under my feet there are '..here()._dshells..' empty shotgun {shells}...';
		end
	end,
	act = 'اینا پوکه‌هامن... دیگه لازمشون ندارم...';
};

function dropshells()
	if here() == deepforest then
		return;
	end
	if not here()._dshells then
		here()._dshells = 2;
	else
		here()._dshells = here()._dshells + 2;
	end
	here().obj:add('dshells');
end

shells = obj {
	nam = 'خشاب',
	inv = 'خشاب شاتگان. به ندرت ازش استفاده می‌کنم، معمولا علیه شکارچی‌های غیرقانونی.',
	use = function(s, on)
		if on == 'gun' then
			if gun._loaded then
				return 'پره...';
			end
			if gun._loaded == false then
				gun._loaded = true;
				dropshells();
				return 'شاتگان رو باز می‌کنم و دو تا فشنگ داخل می‌کنم و شاتگان رو می‌بندم.';
			end
			gun._loaded = true;
			return 'دو تا خشاب برمی‌دارم و می‌ذارمشون توی لول‌های شاتگان دو لولم...';
		end
	end
};

news = obj {
	nam = 'روزنامه',
	inv = [[
	روزنامه جدید... «موسسه مکانیک کوانتوم که اخیرا در تایگا ساخته شده است قویا هر ارتباطی با حوادث مشکوک را رد می‌کند»... عجب...
	]],
	used = function(s, w)
		if w == 'poroh' then
			if have('trut') then
				return 'آتش‌زنه از قبل دارم.';
			end
			inv():add('trut');
			inv():del('poroh');
			return 'روی تیکه روزنامه‌ای که پار کردم مقداری باروت می‌ریزم...';
		end
	end,
};

hamb = obj {
	nam = 'همبرگر',
	inv = function()
		inv():del('hamb');
		return 'یه اسنک خوردم. غذا بود...';
	end
};

zerno = obj {
	nam = 'بلغور',
	inv = 'فقط یه گندم سیاه. دونه‌های گندم سیاه...',
};

shop2 = dlg {
	nam = 'خرید',
	pic = 'gfx/shopbuy.png',
	obj = { 
	[1] = phr('خشاب شاتگان... مهمات لازم دارم...', 'رو چشم... قیمت مثل همیشه', ifmoney..'inv():add("shells")'),
	[2] = phr('گندم...', 'خوبه... ', ifmoney..'inv():add("zerno")'),
	[3] = phr('و یه همبرگر...', 'باشه..', ifmoney..'inv():add("hamb")'),
	[4] = phr('روزنامه‌ی تازه...', 'البته...', ifmoney..'inv():add("news")'),
	[5] = phr('یه حقله چسب عایق...', 'بله. بفرمایید.', ifmoney..'inv():add("iso")'),
	[6] = phr('چیز دیگه‌ای لازم ندارم...', 'هر طور شما بفرمایید.', 'pon(6); back()'),
	[7] = _phr('ضمنا یه نردبون و سیمچین لازم دارم...', 'شرمنده، این چند قلم جنس رو نداریم — ولادیمیر سرش رو تکون می‌ده'), 
	},
	exit = function(s)
		if have('news') then
			s.obj[4]:disable();
		end
	end
};

shopdlg = dlg {
	nam = 'گفتگو با فروشنده',
	pic = 'gfx/shopman.png',
	dsc = 'چشم‌های ریزش من رو با یه نگاه تیز ورانداز می‌کنه.',
	obj = {
	[1] = phr('سلام ولادیمیر! اوضاع چطوره؟', 'سلام، '..me().nam..'... بد نیست... - ولادیمیر یه لبخند موذیانه می‌زنه.', 'pon(2)'),
	[2] = _phr('چند قلم جنس لازم دارم.', 'باشه... بذار ببینیم، چی لازم داری؟', 'pon(2); return walk("shop2")'),
	[3] = phr('پس خداحافظ!...', 'آره... بخت یارت!', 'pon(3); return back();'),
	[4] = _phr('یه مردی الان اینجا بود — کی هست؟', 'اوهوم؟ — ابروهای نازک ولادیمیر کمی بالا می‌رن...','pon(5)'),
	[5] = _phr('معلوم نیست جرا گربه‌ی من رو برداشه... احتمالا فکر کرده ولگرده... اون مردی که کت خاکستری پوشیده کیه؟',
[[
راستش، یه جور رئیسه... - ولادیمیر چونه‌ی نتراشیدش رو می‌خارونه. — تو اون مؤسسه جدیده، همون که سال پیش پشت جنگلمون ساختن...
 — همینطور که ولادیمیر حرف می‌زد عینک دماغیش تکون تکنون می‌خورد — مرتب میاد به مغازه‌ی ما،
از شلوغی خوشش نمیاد — این فیزینکدانا — می‌دونی که... عجیبن, — ولادیمیر شونه بالا انداخت...]],'pon(6)'),
	[6] = _phr('این موسسه‌هه کجاست؟', 
'کیلومتر ۱۲۷... خب، می‌دونی که — ولادیمیر صداش رو آورد پایین — در مورد این مؤسسه شایعاتی هست...', 'me()._know_where = true; inmycar.way:add("inst");pon(7)'),
	[7] = _phr('من فقط می‌رم گربه‌ام رو پس بگیرم...', 'مواظب خودت باش... اگه جای تو بودم... — ولادیمیر سر تکون می‌ده. — ضمنا، فکر کنم اسمش بلینه. کارت اعتباریش رو دیدم... هرچند، می‌دونی که من قبولشون نمی‌کنم. — ولادیمیر لبهاش رو کمی می‌جنبونه و مونوکلش یه جور موذیانه‌ای حرکت می‌کنه'),
	},
};

shopman = obj {
	nam = 'فروشنده',
	dsc = 'یه {فروشنده} پشت پیشخونه. صورت پهن ته‌ریش دارش با یه مونوکل تکمیل شده.',
	act = function()
		return walk('shopdlg');
	end
};

shop = room {
	nam = 'مغازه',
	pic = 'gfx/inshop.png',
	enter = function(s, f)
		if village.obj:look('truck') then
			village.obj:del('truck');
			village.obj:del('mycat');
			return [[
وقتی وارد مغازه شدم چیزی نمونده بود بخورم به یه مرد بگی نگی نچسب با کت خاکستری و کلاه شاپو... با یه صدای هیس مانندی عذرخواهی کرد و کلاهش رو تصنعی بلند کرد... از زیر لبه‌ی کلاهش دندونای سفیدش برق زدن... وقتی به پیشخون رسیدم صدای روشن شدن موتور ماشین به گوشم خورد.]];
		end
	end, 
	act = function(s,w)
		if w == 1 then
			return 'فقط ماشین من تو پارکینگه.';
		end
	end,
	dsc = [[
این مغازه کمی غیرعادیه... اینجا می‌تونی آهن‌آلات و غذا و حتی مهمات پیدا کنی... تعجبی هم نداره، چون این تنها مغازه تو شعاع صد کیلومتری اینجاست...]],
	way = { 'village' },
	obj = {'shopman',vobj(1, 'окно', 'از {پنجره} می‌شه پارکینگ رو دید.') },
	exit = function(s, t)
		if t ~= 'village' then
			return;
		end
		if shopman._wantmoney then
			return 'داشتم می‌رفتم بیرون که با صدای سرفه‌ی خفیف ولادیمیر وایستادم... خب معلومه، یادم رفته پولش رو بدم...', false;
		end
		if not have('news') then
			shop2.obj[4]:disable();
			inv():add('news');
			return 'داشتم می‌رفتم که صدای ولادیمیر جلوم رو گرفت. — روزنامه‌ی جدید رو بردار. — برای تو مجانیه. برمی‌گردم و روزنامه رو برمی‌دارم و می‌رم.';
		end
	end
};

carbox = obj {
	_num = 0,
	nam = function(s)
		if s._num > 1 then
			return 'جعبه‌های توی ماشین';
		else
			return 'جعبه‌ی توی ماشین';
		end
	end,
	act = function(s)
		if inv():srch('mybox') then
			return 'فعلا یه جعبه توی دستمه...';
		end
		s._num = s._num - 1;
		if s._num == 0 then
			mycar.obj:del('carbox');
		end
		take('mybox');
		return 'یه جعبه از تو ماشین برداشتم.';
	end,
	dsc = function(s)
		if s._num == 0 then
			return;
		elseif s._num == 1 then
			return 'یه {جعبه} پشت ماشین منه.';
		-- Again not needed, since "boxes" stays the same for all numerals
		-- elseif s._num < 5 then
		--	return 'There are '..tostring(s._num)..' {boxes} in the cargo body of my car.';
		else	
			return ''..tostring(s._num)..' تا {جعبه} پشت ماشینمه.';
		end
	end,
};

mybox = obj {
	nam = 'یه جعبه',
	inv = 'یه جعبه چوبی دستمه... خیلی خوش ساخته! شاید بدرد بخوره.',
	use = function(s, o)
		if o == 'boxes' then
			inv():del('mybox');
			return 'جعبه رو گذاشتم سر جاش...';
		end
		if o == 'mycar' then
			inv():del('mybox');
			mycar.obj:add('carbox');
			carbox._num = carbox._num + 1;
			return 'جعبه رو گذاشتم پشت وانتم...';
		end
		if o == 'ewall' or o == 'wboxes' then
			if not cam._broken then
				return 'دوربین نمی‌ذاره...';
			end
			if wboxes._num > 7 then
				return "فکر کنم بسه دیگه..."
			end
			inv():del('mybox');
			ewall.obj:add('wboxes');
			wboxes._num = wboxes._num + 1;
			if wboxes._num > 1 then
				return 'یه جعبه گذاشتم روی یه جعبه دیگه...';
			end
			return 'جعبه رو گذاشتم پای دیوار...';
		end
	end
};

boxes = obj {
	nam = 'ящики',
	desc = {
		[1] = 'نزدیک پارکینگ کلی {جعبه} چوبی هست که یه زمانی قلع داخلشون بوده.',
	},
	dsc = function(s)
		local state = 1;
		return s.desc[state];
	end,
	act = function(s, t)
		if carbox._num >= 5 then
			return 'یه درصد احتمالش نیست که جعبه به تعداد کافی برداشته باشم؟...';
		end
		if inv():srch('mybox') then
			return 'فعلا یه جعبه تو دستمه...';
		end
		take('mybox');
		return 'یه جعبه برداشتم.';
	end,
};

village = room {
	nam = 'پارکینگ جلوی مغازه',
	dsc = 'یه جای آشنا جلوی مغازه. پارکینگ. سرتاسر پوشیده از برف...',
	pic = 'gfx/shop.png',
	act = function(s, w)
		if w == 1 then
			return 'سطل‌های معمولی... برف سفید روی آشغال‌ها رو می‌پوشنه...';
		end	
	end,
	exit = function(s, t)
		if t == 'shop' and seen('mycat') then
			return 'باریسک رو صدا کردم ولی به شدت با آشغالدونی سرگرم بود... خب... زیاد طول نمی‌کشه...';
		end
	end,
	enter = function(s, f)
		if ewall:srch('wboxes') and wboxes._num == 1 then
			ewall.obj:del('wboxes');
			ewall._stolen = true;
			wboxes._num = 0;
		end
		if f == 'shop' and not s._ogh then
			s._ogh = true;
			set_music("mus/revel.s3m");
			guydlg:pon(4);
			guydlg:poff(8);
			return 'یه نگاهی به سرتاسر پارکینگ انداختم و داد زدم — باریسک! باریسک! — یعنی گربه‌ام کجا غیبش زد؟';
		end
	end,
	way = { 'road', 'shop' },
	obj = { 'truck', vobj(1,'bins', '{سطل‌های} آشغال بزرگ پوشیده از برف.'), 'guy','boxes' },
};
----------- trying to go over wall
function guardreact()
	pon(7);
	if inst:srch('mycar') then
		inst.obj:del('mycar');
		inmycar.way:add('backwall');
		inst.way:add('backwall');
		return cat([[چهار نفر مسلح به مسلسل تا ماشینم همراهیم کردن. مجبور بودم موتور رو روشن کنم و محوطه موسسه رو ترک کنم. ده دوازده کیلومتر رانندگی کردم تا وقتی که جیپ نظامی نگهبان‌ها از آینه عقب محو شد... ]], walk('inmycar'));
	end
	return cat([[چهار فرد مسلح من رو از باجه نگهبانی پرت کردن بیرون.^^]], walk('inst'));
end

guarddlg = dlg {
	nam = 'نگهبان',
	pic = 'gfx/guard.png',
	dsc = [[صورت استخونی نگهبان رو می‌تونم ببینم. چشم‌هاش مرموز به نظر می‌رسه اما گوشه‌های رو به پایین دهنش فکر گپ زدن باهاش رو از سرت می‌پرونه...]],
	obj = {
	[1] = phr('یکی از پرسنل مؤسسه گربه من رو به اشتباه گرفته. — باید برم داخل.','— کارت عبورتون رو نشون بدین...', 'poff(2); pon(3);'),
	[2] = phr('کارتم رو فراموش کردم. — ممکنه بیام داخل؟','— نه...', 'poff(1); pon(3);'),
	[3] = _phr('بلین رو می‌شناسین؟ گربه‌ام رو گرفته. — باید پسش بگیرم...', '— کارت ندارین؟', 'pon(4)'),
	[4] = _phr('من فقط اومدم گربه‌ام رو پس بگیرم. شماره بلین رو بهم بدین!', 
[[رنگ چشم‌های نگهبان عوض شد. کنج لب‌هاش رفت بالا. — آقای محترم، طوری که متوجه شدم شما کارت عبور ندارین. الان که هنوز امکانش رو دارین اینجا رو ترک کنید...]], 'pon(5, 6)'),
	[5] = _phr('می‌زنم صورتت رو داغون می‌کنم...', 'دست‌های نگهبان رفت طرف مسلسلش. ', 'poff(6); return guardreact();'), 
	[6] = _phr('باشه باشه، من می‌رم...', '— عجله نکن، — نگهبان دیگه لبخندش رو پنهان نمی‌کنه — ازت خوشم نمیاد...','poff(5); return guardreact()'),
	[7] = _phr('همتون رو با شاتگان سوراخ سوراخ می‌کنم...', 'نگهبان اینبار اصلا جواب نمی‌ده. صدای چشم‌های پرخونش از هر کلامی بلندتره.','return guardreact()'),
	},
};
guard = obj {
	nam = 'نگهبان‌ها',
	dsc = [[
چند نفر {نگهبان} تو باجه هستن. ظاهرا همگی مسلح به کلاشینکوفن.
]],
	act = function(s)
		return walk('guarddlg');
	end,
};
kpp = room {
	nam = 'باجه نگهبانی',
	pic = 'gfx/kpp.png',
	dsc = [[باجه نگهبانی هیچ شکی به جا نمی‌ذاره که غریبه‌ها جاشون توی مؤسسه نیست... گیت کنترل تردد... نرده‌های محافظ روی اتاقک... و سکوت.
]],
	obj = { 'guard' },
	way = { 'inst' }
};
inst = room {
	nam = 'مؤسسه',
	pic = 'gfx/inst.png',
	dsc = [[
ساختمون تو یه محوطه‌ی برفی خالی از دل زمین بیرون زده. هیبت مهیبش بیشتر خبر از یک زندان می‌ده تا یک مؤسسه‌ی تحقیقاتی. پشت ساختون ریل راه‌آهن هست.]],
	act = function(s, w)
		if w == 1 then  
			return 'ارتفاع دیوار پنج متره. از این گذشته، روی دیوار سیم‌خاردار هست که فکر کنم بهش برق وصله...';
		end
		if w == 2 then
			return 'آره، ولادیمیر درست می‌گفت... شبیه یه جور پادگان نظامیه...';
		end
		if w == 3 then	
			return 'آره — این شبیه ون مرد کت خاکستریه که باریسک من رو گرفته برده.';
		end
	end,
	used = function(s, w, b)
		if b == 'mybox' and w == 1 then
			return 'فکر کنم نگهبان‌ها فورا متوجه حضورم بشن.';
		end
		if w == 2 and b == 'gun' and gun._loaded then
			return 'بخاطرش می‌اندازنم بیرون... یا می‌گیرنم به باد کتک... نگهبان‌ها خیلی نزدیکن.';
		end
		if w == 3 and b == 'gun' and gun._loaded then
			return 'من دنبال گربه‌ام هستم نه ویرانگری...';
		end
	end,
	obj = {vobj(1, 'wall', 'ساختمون مؤسسه با یه {دیوار} بتنی محصور شده. یه اتاقک نگهبانی اون وسطه.'),
		vobj(2, 'cameras', '{دوربین‌های} حراست از برجک‌ها اطراف رو می‌پان.'),
		vobj(3, 'van', '{ون} مشکی رو می‌تونم پشت دروازه ببینم.')},
	way = { 'road', 'kpp' },
	exit = function(s, t)
		if have('mybox') and t ~= 'inmycar' then
			return 'بان اون جعبه نمی‌تونم اینور اونور برم...', false;
		end
	end,
};

cam = obj {
	nam = 'دوربین مداربسته',
	dsc = function(s)
		if not s._broken then
			return 'یکی از {دوربین‌ها} فاصله‌ی چندانی از اینجا نداره. می‌چسبم به دیوار تا کسی متوجه من نشه.';
		end
		return 'خورده‌های {دوربین} پخش شده رو زمین. هیچ نشده برف روشون رو گرفته.';
	end,
	act = function(s)
		if not s._broken then
			return 'دوربین لعنتی...';
		end
		return 'هع... می‌دونستی که اینطوری می‌شه، مکانیزم لعنتی، نمی‌دونستی؟ تو این فکرم که نگهبان‌ها کی سر و کله‌شون پیدا می‌شه...';
	end,
};

wire = obj {
	nam = 'سیم‌خاردار',
	dsc = function(s)
		if s._broken then
			return 'خورده‌های {سیم‌خاردار} رو می‌تونم ببینم.';
		end
		return '{سیم‌خاردار} رو می‌تونم ببینم.';
	end,
	act = function(s)
		if s._broken then
			return 'نه، امنه. می‌تونم برم تو...';
		end
		return 'اگه بهش برق وصل باشه چی؟';
	end,
};

onwall = room {
	pic = 'gfx/onwall.png',
	nam = 'بالای دیوار',
	dsc = 'روی جعبه‌ها وایستادم، سرم همسطح بالای دیواره. سرده.',
	enter = function(s)
		if have('mybox') then
			return 'با یه جعبه تو دستم نمی‌تونم از دیوار برم بالا.', false;
		end
		if wboxes._num < 5 then
			return 'سعی می‌کنم از دیوار بالا برم... اما خیلی بلنده...',false;
		end
		return 'از رو جعبه‌ها از دیوار بالا می‌رم.';
	end,
	obj = { 'wire' },
	way = { 'backwall' }
};

wboxes = obj {
	_num = 0,
	nam = function(s)
		if (s._num > 1) then
			return 'جعبه‌های سینه‌ی دیوار.';
		end
		return 'یه جعبه پای دیوار.';
	end,
	act = function(s)
		return walk('onwall');
	end,
	dsc = function(s)
		if s._num == 0 then
			return;
		elseif s._num == 1 then
			return 'یه {جعبه} پای دیواره.';
		-- And again only one plural form
		-- elseif s._num < 5 then
		--	return 'There are '..tostring(s._num)..' {boxes}, stacked by the wall.';
		else	
			return ''..tostring(s._num)..' تا {جعبه} چیده شدن پای دیوار.';
		end
	end,
};

ewall = obj {
	nam = 'دیوار',
	dsc = 'ارتفاع {دیوار} اینجا چهار متره. بوران زوزه‌کشان دونه‌های برف رو می‌پاشه پای دیوار.',
	act = function(s)
		if not s._ladder then
			s._ladder = true;
			shop2:pon(7);
		end
		return 'زیادی بلنده... یه نردبون لازم دارم.';
	end
};

backwall = room {
	pic = 'gfx/instback.png',
	enter = function(s, f)
		local st = '';
		if ewall._stolen then
			ewall._stolen = false;
			st = 'ای بابا!!! یه نفر جعبه‌ی من رو دزدیده!!!';
		end
		if f == 'inmycar'  then
			return 'ایول... ظاهرا تونستم بدون جلب توجه برسم اینجا...'..' '..st;
		end
		if f == 'onwall' then
			return
		end
		return 'پرسه‌زنان توی دشت برفی رسیدم به دیوار پشتی.'..' '..st;
	end,
	nam = 'دیوار شرقی مؤسسه',
	dsc = 'پشت مؤسسه هستم.',
	obj = { 'ewall', 'cam' },
	way = { 'inst', },
	exit = function(s, t)
		if have('mybox') and t ~= 'inmycar' then
			return 'با این جعبه تو دستم اینور اونور نمی‌رم...', false;
		end
	end,
};
