------------- now got inside!!! -----------------------
napil = obj {
	nam = 'سوهان',
	dsc = 'یه {سوهان} افتاده زیر دروازه.',
	inv = 'یه چیز زنگ زده...',
	tak = 'سوهان رو برداشتم.',
	use = function(s, w)
		if w == 'knife' and not knife._oster then
			knife._oster = true;
			return 'دارم چاقو رو تیز می‌کنم... حالا تیزه!';
		elseif w == 'gun' and not gun._obrez then
			if here() == wside or here() == sside then
				return 'یه عده این دور و بر هستن!';
			end
			gun._obrez = true;
			return 'نشستم و لوله‌های شاتگان رو بریدم.';
		else
			return 'نه، بریدن اینجا بی‌فایده است...';
		end
	end
};

eside = room {
	pic = 'gfx/eside.png',
	nam = 'پشت مؤسسه',
	dsc = [[ دیواره پشتی ساختمون مؤسسه هستم. یه راه‌آهن اینجاست.]],
	act = function(s,w)
		if w == 1 then
			return 'مسلسل‌ها محوطه جنوبی مؤسسه رو نشونه گرفتن. بهتره تا می‌تونم ازشون فاصله بگیرم.';
		end
		if w == 2 then
			return 'دروازه‌ها فلزی هستن و از داخل قفل شدن.';
		end
	end,
	obj = {
	vobj(1,'gun towers', 'ورودی راه‌آهن توسط مسلسل‌های بالای {برجک‌ها} محافظت می‌شه'),
	vobj(2,'the gates', 'ریل‌ها از کنار {دروازه} بزرگ فلزی رد می‌شن. ظاهرا برای تدارکات استفاده می‌شن.'),	
	'napil',
	},
	exit = function(s, t)
		if t == 'sside' then
			return 'مسلسل‌های جنوبی مظطربم می‌کنن. خیلی خطرناکه.'
				, false
		end
	end,
	enter = function(s, f)
		if f == 'onwall' then
			-- end of episode 1
			inmycar = nil;
			deepforest = nil;
			road = nil;
			forest = nil;
			home = nil;
			shop = nil;
			village = nil;
			kpp = nil;
			inst = nil;
			onwall = nil;
			backwall = nil;
			guydlg = nil;
			shop2 = nil;
			shopdlg = nil;
			guarddlg = nil;
			set_music("mus/ice.s3m");
		end
	end,
	way = {'nside','sside'},
};

card = obj {
	nam = 'کارت عبور',
	inv = [[ کارت عبور یه آدمیه - یه کارت هوشمند الکترونیکی که عکس یه مرد با قیافه‌ی هوی‌متال روشه. روش نوشتخ: الکسی پُدکُوین — طبقه: ۳	 رسته: ماده. عجب...]],
};

alienwear = obj {
	xnam = {'کت جین', 'کت قرمز', 'اورکت', 'ژاکت', 'ژاکت سفید', 
	'کت', 'کت چرمی سیاه', 'کاپشن ورزشی',},
	xinv = {
		'برای این فصل لباس سردیه، اما استیل خاصی داره!',
		'با پس‌زمینه برفی قشنگ به نظر می‌رسه.',
		'یه کت بلند - یه جورایی رِترو به نظر می‌رسه!',
		'من نابودگرم!',
		'صلح کن، نه جنگ!',
		'بهم میاد.',
		'"و هیچ چیز دیگری مهم نیست!"',
		'یه زمانی کوهنوردی دوست داشتم!',
	},
	nam = function(s)
		return s.xnam[s._num];
	end,
	inv = function(s)
		if s._num == 7 and not have('card') then
			inv():add('card');
			return 'جیب‌های کت چرمی رو گشتم و یه کارت پیدا کردم.';
		end
		return s.xinv[s._num];
	end,
};

garderob = obj {
	nam = 'جالباسی',
	dsc = 'سمت راست یه {جالباسیه} با لباس‌های مراجعه‌کننده‌ها.',
	act = function(s, w)
		if have('mywear') or have('alienwear') then
			return 'اینجا خیلی آدم هست. فکر نمی‌کنم بتونم بدون جلب توجه لباسم رو عوض کنم.';
		elseif tonumber(w) and tonumber(w) > 0 and tonumber(w) <= 8 then
			if not me()._walked then
				return 'الان که خیلی تابلوئه...';
			end
			alienwear._num = w;
			inv():add('alienwear');
			ref(s.obj[w]):disable();
			me()._walked = false;
			inv():add('gun');
			return 'با اعتمادبنفس لباس یکی دیگه رو برمی‌دارم و تنم می‌کنم... شاتگانم رو هم برمی‌دارم.';
		else
			return 'باید تصمیم بگیرم...';
		end
	end,
	used = function(s, w)
		if w == 'mywear' then
			garderob.obj:add('mywear');
			inv():del('mywear');
			inv():del('gun');
			return 'کاپشن خلبانیم رو درمیارم. باید شاتگانم رو توش جا بذارم.';
		end
		if w == 'alienwear' then
			local v = alienwear._num;
			ref(s.obj[v]):enable();
			inv():del('alienwear');
			inv():del('gun');
			return 'لباس یکی دیگه رو برمی‌گردونم به جالباسی. شاتگانم رو تو کاپشن خلبانیم پنهان می‌کنم.';
		end
	end,
	obj = {
		vobj(1,'denim jacket','{یه کت دِنیم}.'),
		vobj(2,'red jacket','{یه کت قرمز}.'),
		vobj(3,'overcoat','{یه اُورکت}.'),
		vobj(4,'terminator jacket', "یه {کت} با یادداشت «الان برمی‌گردم»."),
		vobj(5,'jacket with daisies', "یه {کت سفید} گل‌گلی."),
		vobj(6,'coat', "یه {کت پشمی}."),
		vobj(7,'leather jacket','یه {کت چرم مشکی باحال}.'),
		vobj(8,'sport jacket', "یه {کت ورزشی نارنجی}."),
	}
};
portrait = obj {
	nam = 'پرتره‌ها',
	dsc = 'روی دیوارها {پرتره‌های} بزرگ توی قاب‌های چوبی قرار گرفتن.',
	act = 'عجب... یه صورت یکسان توی تمام پرتره‌هاست! صورت یه مرد چهل و چند ساله با یه لبخند بی‌روح و یه نگاه تهی.',
};

salo = obj {
	nam = 'پیه گراز',
	inv = 'این پیه برای خوردن خیلی سفته...',
	use = function(s, w)
		if w == 'trap' and not trap._salo then
			inv():del('salo');
			trap._salo = true;
			return 'همم... فکر کنم یه تله‌موش ساختم!';
		end
	end
};

food = obj {
	nam = 'غذا',
	inv = function (s) 
		inv():del('food');
		return 'بدجور گشنمه، پس همه این غذاهای خوشمزه رو بدون اینکه بشینم می‌خورم. به به... بعدش سینی ظرف‌های خالی رو تحویل می‌دم به پرسنل شست و شو.';
	end
};

knife = obj {
	nam = 'چاقو',
	dsc = 'یه {چاقو} تو سینی می‌بینم.',
	inv = function(s)
		if s._oster then
			return 'یه چاقوی فولادی. بسیار تیز.';
		end
		return 'یه چاقوی فولادی. بسیار کند.';
	end,
	use = function(s, w)
		if w == 'shells' then
			if not s._oster then
				return 'چاقو به اندازه کافی تیز نیست که به درد بخوره.';
			end
			if have('poroh') then
				return 'باروت از قبل دارم.';
			end
			inv():add('poroh');
			return 'یکی از فشنگ‌ها رو باز می‌کنم و باروتش رو بیرون میارم.';
		end
	end,
	tak = function(s)
		if have('knife') then
			return 'یکی از قبل دارم...', false
		end
		return 'فکر کنم برش دارم.';
	end
};

ostatki = obj {
	nam = 'غذای باقیمانده',
	dsc = '{باقیمانده‌ی غذاها} توی ظرف‌ها به طور مساوی پخش شدن.',
	tak = function(s)
		if food._num ~= 2 or have('salo') then
			return 'چیز بدردبخوری نیست...', false;
		else 
			take('salo');
			return 'یه تیکه پیه!', false;
		end
	end
};

podnos = obj {
	nam = 'سینی',
	dsc = '{سینی} من روی میزه.',
	act = function(s, w)
		if w == 1 then
			return 'یه چاقو شبیه چاقو... اونطورها هم تمیز نیست.';
		end
		if w == 2 then
			return 'دیزاین این قاشق حرف خاصی برای گفتن نداره.';
		end
		return 'پلاستیک آبی. لمسش کنی می‌فهمه کمی چربه.';
	end,
	obj = { 'ostatki',
		vobj(1, 'fork', 'یه {چنگال} و'), 
		vobj(2, 'spoon', 'و یه {قاشق} اون کناره.') 
	},
};

moika = room {
	nam = 'پیشخوان شست و شو',
	enter = function()
		return cat('سینی رو می‌برم به بخش شست و شو.^^', walk('kitchen')), false;
	end
};

eating = room {
	pic = 'gfx/podnos.png',
	enter = function(s, f)
		podnos.obj:add('knife');
		inv():del('food');
		if not me()._kitchendlg then
			me()._kitchendlg = true;
			return walk('kitchendlg'), false;
		end
		if f ~= 'kitchendlg' then
			return 'رو یه صندلی دور یه میز خالی می‌شینم و غذام رو می‌خورم.';
		end
	end,
	nam = 'دور میز',
	dsc = 'سطح صاف میز رو زیر دست‌هام حس می‌کنم..',
	obj = { 'podnos' },
	way = { 'moika' },
	exit = function(s)
	end
};

gotfood = function(w)
	inv():add('food');
	food._num = w;
	return back();
end

invite = obj {
	nam = 'دعوتنامه',
	inv = 'دعوتنامه برای سخنرانی بلین: طبقه: ۴ سالن: ۲ همم... باید برم اونجا... باریسک من پیش اونه.',
}

povardlg = dlg {
	nam = 'تو آشپزخونه',
	pic = 'gfx/povar.png',
	dsc = 'صورت تپل و خسته‌ی زن خدمتکار رو که یه کلاه سفید سرشه می‌بینم...',
	obj = {
	[1] = phr('لطفا کمی ازین سبزیجات... بله - و لوبیا!', 'بفرمائید!', [[pon(1); return gotfood(1);]]),
	[2] = phr('سیب‌زمینی با بیکن لطفا!', 'نوش جان!', [[pon(2); return gotfood(2);]]),
	[3] = phr('دو تا سوپ سیر!!!', 'چه انتخاب خوبی!', [[pon(3);return gotfood(3);]]),
	[4] = phr('یه چیزی که سفت نباشه لطفا. زخم معده دارم...', 'بلغور جو دوسر!', [[pon(4); return gotfood(4);]]),
	},
};
kitchendlg = dlg {
	nam = 'صحبت با کارمند',
	pic = 'gfx/ilya.png',
	dsc = 'سینی‌ام رو برداشتم رو دور یک میز خالی نشستم. یه دقیقه بعد یکی سوالی کرد و خواست که سر میز بشینه: «جای کسیه؟»',
	obj = {
	[1] = phr('نه، خالیه...', '— مرسی. چه خبرا؟ از کدوم دپارتمانی؟', [[pon(3,4,5); poff(2);]]),
	[2] = phr('جای کسیه...', '— هاها! چه بامزه! از کدوم دپارتمانی؟', [[pon(3,4,5); poff(1);]]),
	[3] = _phr('همم... انحناهای فضایی...', '— عجب، خیلی قدیمیه!', [[pon(6);poff(4,5)]]),
	[4] = _phr('ععع... جهش‌های کوانتومی...', '- همم؟ در موردش چیزی نشنیدم.', [[pon(6);poff(3,5)]]),
	[5] = _phr('آها... دپارتمان تحقیقات شبه‌فضایی!', '— آها! چه باحال!', [[pon(6);poff(3,4)]]),
	[6] = _phr('همم... ', '— و رده امنتیت چیه؟', [[pon(7,8)]]),
	[7] = _phr('فوق محرمانه!', '— آها! ... ', [[poff(8); pon(9)]]),
	[8] = _phr('ناشناس.', '— واقعا؟ چیزی راجع بهش نشنیدم. شاید حتی از من هم طبقه‌بندی‌شده‌تره...', 
[[poff(7); pon(9)]]),
	[9] = _phr('همم...', '— من ایلیا هستم... — یارو دست لاغرش رو دراز می‌کنه — و اسم شما چیه؟?', [[pon(10, 11, 12)]]),
	[10] = _phr('پ.. پ... پوپکین... واسیلی پوپکین.', '— آها، اسم فامیل خیلی نادریه!', [[poff(11,12); pon(13)]]),
	[11] = _phr('سرگِی.', '— بزن قدش مرد!', [[poff(10,12); pon(13)]]),
	[12] = _phr('گئورگ...', '— باشه، از ملاقاتت خوشحال شدم گوشا!', [[poff(10,11); pon(13)]]),
	[13] = _phr('همم...', 
[[— یه جورایی عجیبی... اما مهم نیست. ما همه اینجا هستیم... — ایلیا قیافه‌ی معنی‌داری به خودش گرفت -... من دارم برای سخنرانی طبقه‌بندی شده‌ی بلین دعوتنامه پخش می‌کنم... فقط برای رفقا... به گمونم ازت خوشم میاد. و رده‌ی امنیتیت هم به اندازه کافی بالاست... پس...]], [[pon(14)]]),

	[14] = _phr('کجاست؟... همم.. سخنرانی کجا برگزار می‌شه؟', 

[[— رده امنیتی ۴. سالن ۲. پس اونجا باش! فرصت خوبیه برای نزدیک شدن به... —ایلیا یه نگاهی به یکی از پرتره‌های روی دیوار انداخت. — آها اصلا داشت یاد می‌رفت! — یه تیکه پلاستیک سفید بهم داد — پس می‌بینمت!... — ععع...]],[[inv():add('invite');return walk('eating');]]), 
	}
};
kitchen = room {
	nam = 'غذاخوری',
	pic = 'gfx/kitchen.png',
	dsc = 'یه غذاخوری کوچک.',
	act = function(s, w)
		if w == 4 then
			return 'دست یکی رو می‌بینم که سینی بشقاب‌های استفاده شده رو می‌بره یه جایی داخل...';
		end
		if w == 1 then
			if not have('food') then
				return 'دور یه میز خالی نشستم. خوب، کمی استراحت کردم - حالا وقت رفتنه!';
			end
			return walk('eating');
		end
		if w == 2 then
			return 'شبیه یه کندوی زنبورن...';
		end
		if w == 3 and not have('food') then
			return cat([[تو صف وایستادم... یه سینی برداشتم، قاشق و چنگال و دستمال. زمان بدجور آروم می‌گذره. بالاخره سفارش می‌دم...^^]], walk('povardlg'));
		end
	end,
	used = function(s, w, ww)
		if w == 1 and ww == 'food' then
			return s:act(1);
		end
	end,
	enter = function(s)
		if not have('mywear') and not have('alienwear') then
			me()._walked = true;
		end
		set_music('mus/foot.mod');
	end, 
	exit = function(s, t)
		if have('food') and t ~= 'eating' then
			return 'همینجوری با یه سینی تو دستم پاشم برم؟ نه.', false;
		end
		if t == 'stolcorridor' then
			set_music('mus/ice.s3m');
		end
	end,
	obj = { 'portrait', 
		vobj(1, 'tables', '{میزهای} چهار و پنج نفره به شکل یکنواختی توی سالن توزیع شدن.'), 
		vobj(2, 'people', 'غذاخوری پر از {آدمه}.'),
		vobj(3, 'queue', 'صف {افراد} گرسنه و منتظر غذا به سرعت جلو می‌ره.'),
		vobj(4, 'dish washing', 'گوشه‌ی سالن یه {دریچه} برای پس دادن سینی و شست و شو هست.'), 
	},
	way = { 'stolcorridor' },
};

stolcorridor = room {
	nam = 'ورودی غذاخوری',
	pic = 'gfx/kitchencor.png',
	dsc = 'راهروی بلند و باریک با نور مهتابی روشن شده.',
	act = function(s, w)
		if w == 1 then
			return 'آره، این آدم‌ها برای غذا خوردن اینجا اومدن...';
		end
	end,
	obj = {'garderob', vobj(1,'люди', '{افراد} تو راهرو بالا و پایین می‌رن.')},
	way = {'sside', 'kitchen'},
	exit = function(s, t)
		if t == 'sside' and not have('mywear') and not have('alienwear') then

			return 'بیرون سرده... بدون یه ژاکت بیرون نمی‌رم... نع...', 
				false;
		end
	end,
	enter = function(s)
		-- generate garderob
		if have('gun') and not gun._hidden then
			return 'شرمنده، اما اگه با یه شاتگان برم داخل احتمالا یه سوالاتی پیش میاد...', false;
		end
		local i
		for i=1, 8 do
			local o = garderob.obj[i];
			ref(o):disable();
		end
		local k = 7;
		for i=1, 5 do
			if not have('alienwear') or k ~= alienwear._num then
				local o = garderob.obj[k];
				ref(o):enable();
			end
			k = rnd(8);
		end
	end
};

sside = room {
	nam = 'ضلع جنوبی',
	pic = 'gfx/sside.png',
	dsc = [[دیوار ضلع جنوبی ساختمان مؤسسه هستم. ]],
	act = function(s, w)
		if w == 1 then
			ways():add('stolcorridor');
			return "نزدیک ورودی شدم و یه پلاک دیدم - «غذاخوری». همم... شاید برم تو بدنباشه؟";
		end
		if w == 2 then
			return 'اونها که بیرون میان به نظر راضی‌تر از اونهایی می‌رسن که می‌رن داخل...';
		end
	end,
	way = {'eside','wside'},
	obj = { vobj(1, "entrance", "نزدیک گوشه‌ی شرقی یه {ورودی} هست."),
		vobj(2, "people", "در ورودی گه‌گاه باز می‌شه و {جمعیت} وارد و خارج می‌شن.")},
	exit = function(s, t)
		if t == 'eside' then
			return 'اگه برم اونجا سیبل خوبی برای مسلسل‌ها می‌شم.', false
		end
	end
};

nside = room {
	nam = 'ضلع شمالی',
	pic = 'gfx/nside.png',
	dsc = 'دیوار ضلع شمالی مؤسسه هستم.',
	way = {'eside','wside' },
	act = function(s, w)
		if w == 1 then
			return 'بله — یه ناودون... به اندازه کافی قوی به نظر میاد. اما فکر نکنم بتونم ازش بالا برم.';
		end
	end,
	obj = { vobj(1, 'tube', 'یه {ناودون} در امتداد گوشه شرقی کشیده شده.')},
};


wside = room {
	nam = 'جلوی مؤسسه',
	pic = 'gfx/wside.png',
	dsc = 'ضلع اصلی مؤسسه.',
	way = {'entrance', 'nside','sside' },
	act = function(s, w)
		if w == 1 then
			return 'ونی که قضه من از اونجا شروع شد...';
		end
		if w == 5 then
			return 'بلندتر از اونیه که دستم بهش برسه. ضمنا قفله. شاید موقع آتش‌سوزی بدرد بخوره ولی من که شک دارم...'
		end
		if w == 2 then
			return 'نگهبان‌ها حتما منو می‌شناسن. بهتره اول باریسکم رو نجات بدم.';
		end
		if w == 3 then
			return 'یه ورودی مرتب... اما فکر اینکه این مؤسسه آدم‌ها رو می‌خوره از سرم نمی‌پره.';
		end
		if w == 4 then
			return 'بیرون تقریبا تارکه، اما افراد همچنان وارد مؤسسه می‌شن...';
		end
	end,
	obj = { vobj(3, 'entrance', '{دروازه اصلی} یه در گردان بزرگ فلزی داره.'),
		vobj(4, 'people', ' می‌ذاره {مردم} داخل و خارج بشن.'), 
		vobj(1, 'van', 'یه {ون} سیاه جلوی دره.'),
		vobj(2, 'checkpoint', 'شصت متر اونورتر من به صختی می‌تونم {اتاقک نگهبانی} رو ببینم.'),
		vobj(5, 'ladder', 'رو ضلع جنوبی دیوار یه {نردبون} اضطراری برای فرار از آتش‌سوزی می‌بینم. نردبون از طبقه دوم تا پنجم کشیده شده.' ),
	}
};

turn1 = obj {
	nam = 'tourniquet',
	dsc = '{گیت‌های چرخان فولادی} راهروی منتهی به آسانسورها رو سد کردن. نمایشگر سبز پیامی نشون می‌ده: <<همه سطوح و رده‌ها>>.',
	act = function(s, w)
		if s._inside then
			s._inside = false;
			here().way:del('lift');
			return 'می‌رم طرف گیت‌ها،کارتم رو می‌کشم و از منطقه حفاظت‌شده خارج می‌شم.';
		end
		if s._unlocked then
			s._inside = true;
			here().way:add('lift');
			return 'می‌رم طرف گیت‌ها، کارت رو می‌کشم و تو یه چشم به هم زدن جلوی آسانسورها هستم.';
		end
		return 'می‌رم طرف یه گیت، اما یه علامت X قرمز می‌بینم. از این جلوتر رفتن عاقلانه نیست.';
	end,
	used = function(s,w)
		if w == 'card' then
			s._unlocked = true;
			s._inside = true;
			here().way:add('lift');
			return 'کارت رو می‌کشم روی یه گیت و یه چراغ سبز می‌بینم. راه بازه. می‌رم طرف آسانسورها.';
		end
	end
};

lustra = obj {
	nam = 'چلچراغ',
	dsc = '{چلچراغ‌های} بزرگ براق بالای سرم آویزون هستن.',
	act = 'نمی‌تونم دست از تماشای اونها بکشم... به گمونم از کریستال ساخته شدن.';

};

divan = obj {
	nam = 'کاناپه',
	dsc = 'گوشه لابی روبروی صندلی نگهبان یه {کاناپه} برای مراجعین هست.',
	act = function(s)
		return 'یه کاناپه خیلی نرم با روکش چرم مشکی.';
	end,
};

entrance = room {
	nam = 'ورودی اصلی',
	pic = 'gfx/entrance.png', 
	dsc = 'عظمت طبقه اول مؤسسه حیرت‌آوره.',
	act = function(s, w)
		if w == 2 then
			return 'یه قفل بزرگ روی گیت‌ها آویزونه.';
		end
		if w == 3 then
			if not turn1._inside then
				return 'گیت‌ها راه من رو به آسانسور سد کردن.';

			end
			return 'به نظر نمی‌رسه چهار تا آسانسور بتونه جواب همه پرسنل مؤسسه رو بده.';
		end
		if w == 4  then
			return 'یه میز از جنس شیشه یا کریستال. بعد از میز یه ترمینال هست.'; 
		end
		if w == 5 then
			return 'به نفع منه که دیگه من رو نبینه.'; 
		end
		if w == 6 then
			return 'آدم... دیدن این همه آدم برای من خیلی غیرعادیه.';
		end
	end,
	obj = {
		'lustra',
		vobj(2, 'gates', '{گیت‌های آهنی} به طرف راه‌آهن همه فضای دیوار شرقی رو اشغال کردن.'),
		vobj(3, 'elevators', '{آسانسورها} وسط سالن هستن.'),
		'turn1',
		vobj(4, 'table', 'قبل از گیت‌ها یه {میزه}.'),
		vobj(5, 'guard', '{نگهبان} پشت میز نشسته.'),
		vobj(6, 'people', '{جمعیتی} که وارد و خارج می‌شن یه صف جلوی آسانسورها تشکیل دادن.'),
		'divan',
	},
	way = { 'wside' },
	enter = function(s, f)
		if have('gun') and f == 'wside' and not gun._hidden then
			return 'به نظرم اگه شاتگانم رو ببرم داخل سوالات زیادی در موردش پیش بیاد... باید جایی پنهانش کنم', false;
		end
	end,
	exit = function(s, t)
		if t == 'wside' then
			turn1._inside = false;
			s.way:del('lift');
		end
	end,
};

pinlift = obj {
	nam = function(s)
		if s._num == 3 then
			return '';
		end
		return 'people';
	end,
	act = function(s)
		return 'منظره‌ی خالی و محزون... سکوت دردآور.';
	end,
	dsc = function(s)
		if s._num == 1 then
			return 'آسانسور پر از {آدمه}.';
		end
		if s._num == 2 then
			return 'چندین {مرد} داخل آسانسور هستن.';
		end
		if s._num == 3 then
			return 'آسانسور خالیه.'
		end
	end
};

lift = room {
	nam = 'آسانسور',
	pic = 'gfx/lift.png',
	dsc = 'داخل آسانسور باید روشن و راحت باشه. ولی کلاستروفوبیا من رو غذاب می‌ده. دگمه‌های روی پنل رو می‌بینم:',
	enter = function(s, t)
		if here() == entrance then
			s._from = 1;
			pinlift._num = 1;
			return 'منتظر یکی از آسانسورها می‌شم و می‌رم داخل';
		end
		pinlift._num = rnd(3);
		if here() == floor2 then
			s._from = 2;
		elseif here() == floor3 then
			s._from = 3;
		elseif here() == floor4 then
			s._from = 4;
		elseif here() == floor5 then
			s._from = 5;
		end
		return 'دگمه‌ی احضار یکی از آسانسورها رو فشار می‌دم و منتظرم می‌شم. بعد مدتی می‌رم داخل آسانسور.';
	end,
	act = function(s, w)
		local to,st
		if not tonumber(w) then
			return
		end
		if w == s._from then
			return cat('نه!!! کلاستروفوبیا مجبورم می‌کنه از آسانسور بزنم بیرون.^^', 
				back());
		end
		if w == 8 then
			st = '';
			if galstuk._wear then
				st = ' راستی، من یه کراوات دارم.';
			end
			if me()._brit then
				return 'تو آیینه نگاه می‌کنم و یه صورت خسته اما تراشیده می‌بینم. این منم.' .. st;
			end
			return 'تو آیینه نگاه می‌کنم و یه صورت خسته و نتراشیده می‌بینم. این منم.'..st;
		end
		if w == 6 or w == 7 then
			return 'بی‌قرارم... اما نباید شتابزده تصمیم بگیرم.';
		end
		if w == 1 then
			to = 'entrance';
		else 
			to = 'floor'..w;
		end
		return cat('دگمه رو فشار می‌دم و منتظر می‌مونم. کلاستروفوبیا تقریبا ناکارم می‌کنه، اما منتظر می‌مونم... آخ... بالاخره رسیدم!^^',
			walk(to));
	end,
	exit = function()
		return 'درهای آسانسور پشت سرم بسته می‌شن.';
	end,
	obj = {
		vobj(1,'1', '{۱} و'),
		vobj(2,'2', '{۲} و'),
		vobj(3,'3', '{۳} و'),
		vobj(4,'4', '{۴} و'),
		vobj(5,'5', '{۵} و'),
		vobj(6,'stop','{توقف}'),
		vobj(7,'go','و {حرکت}.'),
		vobj(8,'mirror', 'دیواره‌ی پشتی آسانسور یه {آینه} است.'),
		'pinlift',
	},
};

floor2 = room {
	nam = 'محوطه طبقه دوم',
	pic = 'gfx/floor2.png',
	dsc = "طبقه دوم هیچ پنجره‌ای نداره. سقف کوتاه و دیوارهای خاکسری-سبز. اینجا سرد و آرومه.",
	act = function(s, w)
		if w == 1 then
			return 'در ظاهرا از سرب ساخته شده... گمان نمی‌کنم به هیچ طریقی بتونم برم داخل. که البته دلیل خوبی داره. زیر تابلو که برچسب که روش نوشته: <<سطح: ۲, رده: انرژی اتمی>>.';
		end
		if w == 2 then
			return 'آره، یکی از همین آسانسورها من رو آورد به این محل لعنتی...';
		end
	end,
	obj = { 
		vobj(1, 'در', 'یه {در} عظیم می‌بینم با این علامت:  <<هشدار! تشعشع زیاد!!!>>'),
		vobj(2, 'آسانسورها', 'انگار که هر چهار آسانسور به طرز غم‌انگیزی به من نگاه می‌کنن.'),
	},
	way = { 'lift' },
};

resh = obj {
	nam = 'نرده',
	dsc = function(s)
		if not s._unscrew then
			return 'حفره توسط یک {توری} فلزی محافظت شده.';
		end
		if vent._off then
			return 'داخل حفره می‌تونم پره‌های یک فن بزرگ تهویه هوا رو تشخیص بدم. {توری} روی زمین افتاده.';
		end
		return 'پره‌های فن بزرگ تهویه هوا دارن می‌چرخن. {توری} افتاده روی زمین.';
	end,
	act = function(s)
		if s._unscrew then
			return 'این کاریه که می‌شه با یه چاقوی کند انجام داد به شرطی که مهارت به خرج بدی و صبور باشی!';
		end
		if not stoly._moved then
			return 'دستم بهش نمی‌رسه...';
		end
		return 'توری توسط دوازده پیچ حسابی محکم شده...';
	end,
	used = function(s, w)
		if w == 'knife' and not s._unscrew and stoly._moved then
			s._unscrew = true;
			return 'از میز بالا می‌رم و سعی می‌کنم با چاقو پیچ‌ها رو باز کنم. یه کم طول می‌کشه. ولی بالاخره انجامش می‌دم. توری می‌افته روی زمین. از میز پایین میام.';
		end
		if w ~= 'stol' then
			return 'راه نداره...';
		end
	end,
};

vent = obj {
	nam = 'حفره‌ی تهویه هوا',
	dsc = 'وسط سقف یه {سوراخ} بزرگ تهویه هوا هست',
	act = function(s)
		if not stoly._moved then
			return 'نمی‌تونم بهش برسم...';
		end
		if not resh._unscrew then
			return 'می‌رم روی میز و حفره رو وارسی می‌کنم. با توری فلزی پوشونده شده... از رو می‌رم و میام پایین.';
		end
		if not s._off then
			return 'میرم بالای میز و پره‌های تیز فن رو تماشا می‌کنم. به نظرم خیلی خطرناکه...';
		end
		if not s._trap then
			return 'از میز بالا می‌رم. در حالی که لبه‌های سوراخ رو گرفتم سعی می‌کنم برم داخل... اینجا تاریک و خیسه. تقریبا داخل شدم که چشم‌های قرمز و دندونهای یک موش رو می‌بینم... نع!!! به پشت می‌افتم روی میز و بعد می‌خورم زمین';
		end
-- here we go!
		return walk('toilet');
	end,

	used = function(s, w)
		if w == 'stol' then
			return
		end
		if not stoly._moved  then
			return 'به حفره نمی‌رسم...';
		end
		if not resh._unscrew then
			return 'حفره با توری پوشونده شده...';
		end
		if not s._off then
			return 'به خاطر پره‌های فن نمی‌تونم...';
		end
		if w == 'gun' and not s._trap then
			gun._loaded = false;
			return 'می‌رم بالای میز و شاتگان رو به طرف حفره نشونه می‌رم. با یه صدای بم هر دو لول شلیک می‌کنن. گوش می‌دم. حفره ساکته... میام پایین. به نظرم بی‌فایده است...';
		end
		if w == 'trap' then
			if not trap._salo then
				return 'تله رو روی لبه‌ی سوراخ کار می‌ذارم. منتظر می‌شم. اما موشه احمق نیست. تله رو دوباره برمی‌دارم. طعمه لازم دارم.';
			end
			inv():del('trap');
			vent._trap = true;
			return 'می‌رم بالای میز و تله‌ی طعمه‌گذاری شده رو روی لبه‌ی حفره جاسازی می‌کنم... لازم نیست مدت زیادی صبر کنم... صدای چفت شدن و آخرین جیع موش کافیه که بفهمم کار انجام شده!';
		end
	end,
	obj = {
		'resh'
	}
};

stol = obj {
	nam = 'میز',
	inv = 'کنج یکی از میزها رو می‌گیرم. ظاهرا از چوب بلوط ساخته شده.',
	use = function(s, w)
		if w == 'vent' or w == 'resh' then
			inv():del('stol');
			stoly._moved = true;
			return 'زور زدم و یکی از میزها رو کشیدم وسط اتاق.';
		end
	end
};

stoly = obj {
	nam = 'میزها',
	dsc = function(s, w)
		if not s._moved then
			return 'در چهار گوشه‌ی اتاق {چهار میز} از جنس چوب بلوط به ترتیب قرار گرفتن.';
		end
		return '{سه میز} از جنس چوب بلوط گوشه‌های اتاق قرار دارن. یک میز به وسط اتاق کشیده شده.';
	end,
	act = function(s, w)
		if s._moved then
			return 'یه میز رو بذارم رو یکی دیگه؟ نه، از پسش برنمیام...';
		end
		inv():add('stol');

		return [[مبلمان خوبیه... اما میز خونه خودم بهتره - اونو با دست‌های خودم ساختم. گوشه‌ی یه میز رو می‌گیرم.]];
	end
};

eroom = room {
	nam = 'STR دپارتمان',
	pic = function()
		if not stoly._moved then
			return 'gfx/sto.png';
		end
		if not resh._unscrew then	
			return 'gfx/sto2.png';
		end
		return 'gfx/sto3.png';

	end, 
	dsc = [[توی یک اتاق کوچک با دیوارهای بژرنگ هستم.]],
	enter = function(s, f)
		if f == 'cor3' then
			return [[در رو باز کردم و نگاهی به داخل انداختم. عجب... خالیه! فکر کنم یه سر و گوشی این اطراف آب بدم...]];
		end
		if f == 'toilet' then
			return 'خوب... توری فلزی کف توالت رو بلند می‌کنم و وارد تاریکی می‌شم... ظرف چند دقیقه از سوراخ تهویه هوا می‌پرم روی میز و میام روی زمین.';
		end
	end,
	act = function(s, w)
		if w == 1 then
			return 'کرکره‌ها رو کنار می‌زنم و به تاریکی بیرون خیره می‌شم. انعکاس محو خودم رو روی شیشه می‌بینم. به پایین که نگاه می‌کنم برج‌های مسلسل و ریل‌های راه‌آهن رو می‌بینم.';
		end
		if w == 2 then
			return 'فقط یه ترمیناله. کلاینت‌هایی که به سرورهای موسسه وصل می‌شن. هرچند، من علاقه‌ای بهشون ندارم. ده ساله که دست به کامپیوتر نزدم.';
		end
	end,
	obj = { 
		vobj(1, 'window', 'یه {پنجره} شرقی.'),
		'stoly',
		vobj(2, 'terminals', 'روی هر میز یه {ترمینال} با یه صفحه نمایش ۱۷ اینچی هست.'),
		'vent',
		'portrait',
	},
	way = { 'cor3' },
	exit = function()
		inv():del('stol');
	end
};

key = obj {
	nam = 'کلید',
	dsc = 'یکی {کلیدش} روی روی در جا گذاشته.',
	tak = 'بادقت کلید رو می‌کشم بیرون و می‌ذارم توی جیبم.',
	inv = 'در کمال تعجب قفل‌های در معمولی در کنار قفل‌های الکترونیکی پیچیده در موسسه بکار رفتن!',
};

room33 = room {
	nam = 'اتاق',
	pic = 'gfx/bholes.png',
	dsc = [[چند ثانیه‌ای کنار در مکث می‌کنم. بعد بازش می‌کنم و می‌رم داخل.]],
	act = function(s, w)
		if w == 1 then
			return cat('یه مرد موخاکستری می‌چرخه طرفم و من رو برای لحظه‌ای تماشا می‌کنه. - تو کی هستی؟ فورا برو بیرون!!^^',back());
		end
	end,
	obj = { 
		vobj(1, 'people', [[یه گروه {آدم} با روپوش‌های سفید فنی می‌بینم که کنار یک بورد وسط اتاق ایستادن و به شدت مشغول بحث هستند.]]),
		'portrait',
		'key' 
		};
	way = { 'cor3' },
	exit = [[با دقت اتاق رو ترک می‌کنم.]];
};

room3x = room {
	nam = 'room',
	enter = function(s, f)
		if s._num == 2 then
			return [[لای در رو باز می‌کنم و داخل رو نگاه می‌کنم.
			یع اتاق چهارگوش با دو پنجره.
			کلی آدم در امتداد دیوار جلوی ترمینالها نشستن
			با عجله در رو می‌بندم.]], false;
		end
		if s._num == 4 then
			return [[دستگیره فلزی سرد رو می‌گردم و در رو با دقت بازمی‌کنم... - شبیه‌سازی در حال اجراست!!! - صدای عصبانی یکی رو از داخل می‌شنوم. دستگیره رو رها می‌کنم و در بسته می‌شه...]],
			false;
		end
		if s._num == 5 then
			ref(f).way:add('eroom');
			return walk('eroom'), false;
		end
		if s._num == 6 then
			return [[شروع به باز کردن در می‌کنم و همزمان صدایی می‌شنوم که دائم بلندتر می‌شه. - کدوم نادونی در رو نبسته؟! - یکی اون تو خیلی عصبانیه. در رو با عجله می‌بندم.]], 
			false;
		end
	end,
};

switch = obj {
	nam = 'switch',
	dsc = function(s)
		local t
		if vent._off then
			t = ' در وضعیت <<وصل>>.';
		else
			t = ' در وضعیت <<قطع>>.';	
		end
		return 'تو گوشه‌ی کنار در ورودی یه {سوئیچ} هست.'..t;
	end,
	act = function(s)
		if vent._off then
			vent._off = false;
			return 'روشن می‌کنم!'
		end
		if not cor3._locked then
			return [[سوئیچ رو قطع می‌کنم و می‌رم. ولی یک دفعه یکی از درها باز می‌شه و یه صدای پیر تو کوریدور فریاد می‌زنه: این چه وضع فلان فلان شده‌ایه!!! غیرممکنه!!! اصلا نمی‌شه کار کرد!!! دوباره روشنش کن!!! - مجبورم برگرم سر سوئیچ و دوباره روشنش کنم.]];
		end
		vent._off = true;
		return 'خاموش می‌کنم!';
	end
};

cor3 = room {
	nam = 'راهرو طبقه سوم',
	pic = 'gfx/cor3.png',
	enter = function(s, f)
		if f == 'floor3' then
			return 'کارت رو روی کارتخوان می‌کشم... چراغ قرمز چشمک می‌زنه و بعد سبز می‌شه... راه بازه!';
		end
	end,
	dsc = 'راهرو طولانی تا انتهای ساختمان ادامه داره. لامپهای مهتابی نور کمی از سقف ساطع می‌کنن. کف راهرو یه فرش سبزرنگه.',
	act = function(s, w)
		if w == 1 then
			return 'به طرف یکی از درها می‌رم و نگاهی توی سوراخ کلید می‌اندازم... آدم‌های لباس‌سفید دور یه دستگاه عجب حرکت می‌کنن. درست مثل زنبورها... به نظرم این اتاق‌ها آزمایشگاه هستن.';
		end
		if not tonumber(w) then
			return nil, false
		end
		if w == 3 then
			if s._locked then
				return 'این اتاق قفله... صدای نه چندان بلند ولی پرقدرتی می‌شنوم. دلم نمی‌خواد بازش کنم.';
			end
			return walk('room33');
		end
		if tonumber(w) >=2 and tonumber(w) <=6 then
			room3x._num = w;
			return walk('room3x');
		end
		if w == 7 then
			return 'یه پنجره جنوبی... بیرون تاریکه. چیزی جز دونه‌های برفی که به پنجره می‌خورن نیست...';
		end
		if w == 8 then
			return 'سر بزنیم؟';
		end
	end,
	used = function(s, w, ww)
		if w == 1 or w == 2 or w == 4 or w == 5 or w == 6 then
			return 'امکان نداره...';
		end 
		if w == 3 and ww == 'key' then
			if s._locked then
				return 'از قبل قفله...';
			end
			s._locked = true;
			return 'کلید رو وارد سوراخ کلید می‌کنم و در رو دو قفله می‌کنم. کلید رو بیرون می‌کشم و می‌ذارمش توی جیب.';
		end
	end,
	obj = {
		vobj(1, 'white doors', 'سمت راست {درهای} سفید فلزی پنجره‌دار قرار دارن.'),
		vobj(2, 'gravity', 'سمت چپ چندین در با برچسب قرار دارن: {جاذبه},'),
		vobj(4, 'simulation', '{شبیه‌سازی}'),
		vobj(5, 'STR effects','{اثرات STR},'),
		vobj(3, 'black holes', '{سیاهچاله‌ها},'),
		vobj(6, 'quasispace', '{شبه‌فضا}.'), 
		vobj(7, 'window', '{پنجره} رو در انتهای راهرو می‌بینم.'),
		vobj(8, 'مستراح', '{مستراح‌ها} نزدیک پنجره هستن.'),
		'switch',
		'portrait',
	},
	way = {'floor3', 'toilet3', 'toiletw'},
};

mylo = obj {
	nam = 'soap',
	inv = function(s)
		if s._pena then
			return 'یک قالب صابون و مقداری کف.';
		end
		return 'یه قالب صابون.';
	end,
	dsc = 'یه تکه {صابون} توی سینکه',
	tak = 'صابون لیز رو گرفتم... دوباره افتاد توی سینک، اما دوباره گرفتمش و گذاشتمش توی جیبم...';
};

sushka = obj {
	nam = 'دست‌خشک‌کن',
	dsc = 'یه {دست‌خشک‌کن} اون نزدیکی آویزونه.',
	act = function(s,w)
		return 'دست‌هام رو می‌گیرم نزدیک دست‌خشک‌کن و شروع می‌کنه به کار... دِجاوو...';
	end,
};

umyvalnik = obj {
	nam = 'روشویی',
	dsc = '{روشویی} نزدیک ورودیه.',
	act = function(s)
		if me()._mylo then
			me()._mylo = false;
			return 'کف صابون رو از صورتم می‌شورم...';
		end
		return 'با ولع آب کلردار رو می‌نوشم... آره - این آب مثل آب نهر کلبه خودم نمی‌شه...'; 
	end,
	used = function(s, w)
		if w == 'mylo' then
			mylo._pena = true;
			return 'صابون رو می‌گیرم تو آب گرم...';
		end
	end
};

toilet3 = room {
	nam = 'مستراح',
	pic = 'gfx/toil3.png',
	dsc = 'تو مستراح هستم. یه ساختار استاندارد. بدون پنجره. سرامیک سفید.',
	act = function(s, w)
		if w == 2 then
			return 'همشون اشغالن!';
		end
		if w == 3 then
			return 'ملت به شکل مساوی تو مستراح پخش شدن. همه اتاقک‌ها اشغالن. چند مرد منتظر نوبتشون هستن.';
		end
	end,
	obj = { 
		'umyvalnik',
		'mylo',
		'tzerkalo',
		'sushka',
		vobj(2, 'closets', 'تو این سرویس بهداشتی چهار تا {مستراح} هست.'),
		vobj(3, 'people', 'چند نفر} اینجا هستن}...'),
	},
	way = { 'cor3' }, 
	exit = function()
		if me()._mylo then
			return 'با کف روی صورت؟ نه ...', false
		end
		objs():del('face');
	end
};

floor3 = room {
	nam = 'محوطه طبقه سوم',
	pic = 'gfx/floor3.png',
	dsc = [[محوطه طبقه سوم به قدر کافی بزرگه. دیوارهای بژرنگ. سقف بلند.]],
	act = function(s, w)
		if w == 1 then
			return 'یه دقیقه به پنجره خیره می‌شم... یه صحرای سفید در دل تاریکی... در در همین لحظه پی می‌برم تو چه ناکجا‌آبادی هستم...';
		end
		if w == 2 then
			if not s._unlocked then
				return 'فلز با روکش چرم. در یه کارتخوان داره. روی در نوشته: <<طبقه: ۳ رده: فیزیک کاربردی>>';
			end
			return walk('cor3');
		end
		if w == 3 then
			return 'انصافا در محکمیه... از در کلبه‌ی من خیلی قوی‌تره... در یه کارتخوان داره. روی در نوشته: <<طبقه: ۳، رده: نانوتکنولوژی>>';
		end
	end,
	used = function(s,w,ww)
		if ww ~= 'card' then
			return 'کمکی نمی‌کنه...';
		end
		if w == 2 then
			s._unlocked = true;
			s.way:add('cor3');
			return walk('cor3');
		end
		if w == 3 then
			return 'کارت رو می‌کشم رو کارتخوان. یه صدای بیپ گوشخراش می‌شنوم - دسترسی ممنوع.';
		end
	end,
	obj = { 
		vobj(1, 'پنجره', 'یه {پنجره} پهن غربی.'),
		vobj(2, 'brown door', 'دست راست پنجره یه {در} قهوه‌ای هست.'),
		vobj(3, 'white door', 'یه {در} سفید سمت چپ.'),
	},
	way = { 'lift' },
};

britva = obj {
	nam = 'تیغ اصلاح',
	dsc = 'یه {تیغ اصلاح} داخل سینکه.',
	tak = 'تیغ رو می‌ذارم تو جیبم با این امید که کسی متوجه من نشده باشه.',
	inv = 'یه تیغ کمی زنگ زده...',
};

face = obj {
	nam = 'face',
	dsc = 'آینه {صورتم} رو بازتاب می‌ده.',
	act = function(s)
		local st = '';
		if me()._brit then
			st = 'خوب اصلاح شده.';
		elseif me()._mylo then
			st = 'با کف صابون روش.';
		end
		if galstuk._wear then
			st = st..'ضمنا با یه کراوات.';
		end
		return 'این انعکاس صورت منه.'..st;
	end,
	used = function(s, w)
		if w == 'mylo' then
			if me()._brit then
				return 'صورتم رو قبلا تراشیدم...';
			end
			if not mylo._pena then
				return 'صابون خیلی خشکه...';
			end
			if not have('britva') then
				return 'صابون رو می‌ذارم روی صورتم و کثافت رو می‌شورم... به به...';
			end
			me()._mylo = true;
			return 'به صورتم کف صابون می‌زنم...';
		end
		if w == 'britva' then
			if me()._brit then
				return 'صورتم رو قبلا تراشیدم...';
			end
			if not me()._mylo then 
				return 'باید به صورتم کف صابون بزنم...';
			end
			me()._brit = true;
			me()._mylo = false;
			return 'دارم صورتم رو می‌تراشم... بعد صورتم رو می‌شورم...';
		end
	end
};

tzerkalo = obj {
	nam = 'آینه',
	dsc = 'یه {آینه} همونجایی که باید نصب شده - بالای سینک.',
	act = function(s)
		local st = '';
		objs():add('face');
		if galstuk._wear then
			st = ' ضمنا با یه کراوات...';
		end
		if me()._brit then
			return 'صورت غمگین اما خوب اصلاح شده.' .. st;
		end
		return 'صورت نتراشیده جنگلی از توی آینه به من خیره می‌شه.' .. st;
	end,	
};

toilet = room {
	nam = 'مستراح',

	pic = 'gfx/toil4.png',
	dsc = 'باید اعتراف کنم مستراحش حسابی بزرگه. سرامیک سفید. لکه‌های زرد. رطوبت و صدای جریان آب. یه در چوبی به راهرو باز می‌شه.',
	enter = function(s, f)
		if f == 'eroom' then
			return 'خودم رو می‌کشم بالا توی حفره‌ی تهویه هوا. داخل خاکی و ساکته. مدتی توی هزارتوی سیستم تهویه هوا می‌پلکم تا بالاخره یک چراغ بالای سرم پیدا می‌کنم. لحظه‌ای بعد توری فلزی کف مستراح رو هل می‌دم...';
		end
	end,
	act = function(s, w)
		if w == 2 then
			return 'آره... خوش‌شانسم. به نظرم توالت مردونه است...';
		end
		if w == 3 then
			return 'سیستم تهویه هوای عجیبی دارن. اما به برکت همون سیستم من اینجام!...';
		end
	end,
	obj = { 
		vobj(2, 'closets', 'There are only 2 {closets} in this toilet.'),
		'umyvalnik',
		'britva',
		'tzerkalo',
		'sushka',
		vobj(3, 'lattice', 'یه {توری فلزی} روی زمینه.');
	},
	way = { 'eroom', 'cor4'},
	exit = function(s, t)
		if me()._mylo then
			return 'با صورت کفی؟ نه...', false
		end
		objs():del('face');
		if t ~= 'eroom' then
			return 'با دقت از مستراح میام بیرون.';
		end
	end
};

toiletw = room {
	nam = 'women closet',
	enter = function(s, w)
		return 'هیهات... چیزی نمونده بود که مرتکب یک اشتباه بشم...', false;
	end
};

function room4x_hear()
	local ph = {
	[1] = '...طبق اصل عدم قطعیت مکانیک کوانتومی، دانستن همزمان موقعیت و کنش یک ذره غیرممکن است...',
	[2] = '...طبق نظریه مکانیک کوانتومی، مقدارسنجی باعث فروریزش آنی (رُمبش) تابع موجی سیستم کوانتومی به یکی از حالت‌های ویژه (eigenstate) از وضعیت قابل مشاهده‌ی سنجیده شده می‌شود...',
	[3] = '...تقلیل بسته‌ی موج پدیده‌ایست که طی آن یک تابع موج پس از برهمکنش با مشاهده‌گر به یکی از حالت‌های خاص خود تغییر حالت می‌دهد...',
	[4] = '...این تئوری پیش‌بینی می‌کند که هر دو مقدار برای یک ذره نمی‌توان معلوم باشد، با این وجود آزمایش EPR نشان می‌دهد که این امر امکانپذیر است...',
	[5] = '...اصل محل مرجع عنوان می‌کند که فرآیندهایی روی داده در یک محل نمی‌باید هیچ تاثیری بر روی المان‌های واقعی در محلی دیگر داشته باشند...';
	[6] = '...و ادعا می‌کند که با در نظر گرفتن یک آزمایش خاص، که طی آن نتیجه‌ی سنجش پیش از سنجش مشخص است، باید چیزی در جهان واقع وجود داشته باشد، یک «عنصر واقعیت»، که خروجی مقدارسنجی را تعیین می‌کند...',
	[7] = '...تفسیر چندجهانی انگاره‌ای از مکانیک کوانتومی است که مدعی واقعیت عینی تابع موج کلی است، اما حقیقت فروریزش تابع موج را انکار می‌کند، که نتیجه می‌دهد که تمام تاریخچه‌ها و آتیه‌های آلترناتیو ممکن واقعی هستند و هریک یک جهان یا هستی واقعی را نمایندگی می‌کنند...',
	[8] = '...اثر اصیل اِوِرِت حاوی یک نکته‌ی کلیدی است: معادلات فیزیکی که تغییر و تحول زمان یک سیستم را بدون مشاهده‌گر توکار مدلسازی می‌کنند، برای مدلسازی سیستم‌هایی با مشاهده‌کر نیز کافی هستند. به صور خاص، هیچ فروریزش تابع موجی که با مشاهده فعال بشود وجود ندارد که تفسیر کپنهاگن آن را پیشنهاد بدهد...',
	[9] = '...بنابراین گفته می‌شود که ذرات در هم تنیده‌اند. این می‌تواند بعنوان یک ابروضعیت کوانتومی دو وضعیت در نظر گرفته شود، که ما وضعیت الف و وضعیت ب می‌نامیم...',
	[10] = '...آلیس گردش حول محور z را اندازه‌گیری می‌کند. او می‌تواند یکی از دو حالت ممکن را بدست بیاورد: +z یا -z. فرض کنید که او +z بدست می‌آورد. بنابر مکانیک کوانتومی، حالت کوانتومی سیستم به وضعیت الف فرومی‌ریزد. حالت کوانتومی نتیجه احتمالی هر مقدارسنجی انجام شده روی سیستم را تغیین می‌کند. در این مورد، اگر در ادامه باب گردش حول محور z را اندازه بگیر، به احتمال ۱۰۰٪ او وضعیت -z را بدست می‌آورد. و همچنین اگر آلیس -z بگیرد، باب +z خواهد گرفت...',
	};
	return ph[rnd(10)];
end

room4x = room {
	nam = 'room',
	enter = function(s, f)
		if s._num == 1 then
			return 'با احتیاط دستگیره رو لمس می‌کنم و سعی می کنم داخل شوم. بسته است...'
			, false;
		elseif s._num == 2 then
			return 'به در نزدیک می‌شم و گوش می‌کنم... - '..room4x_hear()..
			' — عجب... بهتره ادامه بدم...',
			false;
		elseif s._num == 3 then
			return 'به در نزدیم می‌شم و گوش می‌کنم... - می‌شنوم که کسی با شدت مشغول بحث است... - بهتره برم...', false;
		elseif s._num == 4 then
			return 'در رو باز می‌کنم و داخل می‌شم. ۱۲ جفت چشم با دقت من رو نگاه می‌کنن. یک جفت دیگر از چشم‌ها متعلق به مردی است که پای تخته ایستاده. - ببخشید، فکر کنم متوجه در نشدم... - این تنها چیزیه که تو اون وضعیت می‌تونم بگم. سریع خارج می‌شم...', false;
		elseif s._num == 5 then
			return 'بسته است...', false;
		end
	end,
};

galstuk = obj {
	nam = function(s)
		if s._gal then
			return 'کراوات';
		end
		return 'پارچه‌کهنه';
	end,
	inv = function(s, w)
		if not s._gal then
			s._gal = true;
			return 'پارچه‌کهنه رو وارسی می‌کنم و متوجه می‌شم زمانی کراوات بوده.'
		end
		if s._hot then
			if not s._wear then
				s._wear = true;
				return 'با عزت کراوات رو می‌زنم...';
			end
			return 'کراوات رو می‌بندم...';
		end
		if s._mylo then
			return 'همه‌اش تو صابونه!';
		end
		if not s._water then
			return 'کثیفه! نمی‌بندمش!';
		end
		if not s._hot then
			return 'خیسه! نمی‌بندمش!';
		end
	end,
	used = function(s, w)
		if s._wear then
			return 'کراوات رو می‌بندم...';
		end
		if w == 'mylo' then
			if not mylo._pena then
				return 'صابون خشکه...';
			end
			s._mylo = true;
			if not s._gal then
				s._gal = true;
				return 'همینکه دارم به پارچه‌کهنه صابون می‌زنم، می‌فهمم که زمانی کراوات بوده.';
			end
			return 'مقداری صابون به کراوات می‌زنم...';
		end
	end,
	use = function(s, w)
		if s._wear and w ~= 'hand' then
			return 'کراوات رو می‌بندم...', false;
		end
		if w == 'umyvalnik' then
			if not s._mylo  then
				return 'با آب خالی؟ گمان نمی‌کنم بتونه گچ رو بشوره ببره...';
			end
			s._water = true;
			s._mylo = false;
			return 'کراوات رو تو آب گرم می‌شورم...';
		end
		if w == 'sushka' then
			if not s._water then
				return 'چرا باید خشکش کنم؟';
			end
			s._hot = true;
			s._water = false;
			return 'تو پنج دقیقه کراوات رو خوب خشک می‌کنم...';
		end
	end
};

room46 = room {
	nam = 'اتاق سمینار شماره ۶',
	pic = 'gfx/room4.png',
	enter = 'در رو باز می‌کنم و داخل می‌شم... اتاق خالیه...',
	dsc = 'داخل اتاق سمینار هستم... چندین میز در دو ردیف رو به تخته چیده شدن.',
	act = function(s, w)
		if w == 1 then
			if not have('galstuk') then
				inv():add('galstuk');
				return 'یه پارچه‌کهنه روی تخته می‌بینم. برش می‌دارم.';
			end
			return 'عجب... حتی یه کلمه هم از این چیزها سر در نمیارم...';
		end
		if w == 2 then
			return 'می‌بینم چطور پرژکتورها دارند برف رو ان پایین جستجو می‌کنن...';
		end
		if w == 3 then
			return 'کنار کیبورد می‌شنم، اما به یاد میارم که من گذشته‌ام رو پشت سر گذاشته‌ام... دیگه یه هکر نیستم - یه جنگلبانم.';
		end
	end,
	obj = {
		vobj(3,'terminal', 'روی هر میز یک {ترمینال} قرار گرفته.');
		vobj(1,'board', 'روی {تخته} تعدادی معادله عجیب نوشته شده...'),
		vobj(2,'window', 'یه {پنجره} شرقی.'),
		'portrait',
	},
	way = { 'cor4' },
};

facectrl = dlg {
	nam = 'face control',
	pic = 'gfx/guard4.png',
	dsc = 'صورت نچسب و غیردوستانه مامور چاق امنیتی رو می‌بینم.',
	obj = {
		[1] = phr('اومدم تا به درس بلین گوش کنم...',
		'— من نمی‌دونم تو کی هستی، — مامور نیشخند می‌زنه — اما به من گفته شده فقط افراد موجه رو اینجا راه بدم.',
		[[pon(2);]]),

		[2] = _phr('یه دعوتنامه دارم!', 
		'— برام مهم نیست! نگاهی به خودت بنداز! اواخر اصلا یه آینه دیدی؟ اومدی به خود بلین گوش بدی! بـ-لـین! دست راست... - مامور لحظه‌ای با احترام تامل می‌کنه - خوب... بزن به چاک!',
		[[pon(3,4)]]),

		[3] = _phr('داغونت می‌کنم صورت تپلی!', '— باشه، دیگه کافیه... - دستان قدرتمند من رو هل می‌دن توی راهرو... شانس آوردم که هنوز یه تیکه سرهم هستم...',
		[[poff(4)]]),

		[4] = _phr('گراز! بهت گفتم که دعوتنامه دارم!',
			'— چـــی؟ چشمای مامور دارن قرمز می‌شن... اُردنگی پرزور من رو پرت می‌کنه توی راهرو... می‌تونست بدتر ازین باشه...',
		[[poff(3)]]),

		[5] = _phr('می‌خوام به درس لنین گوش کنم...',
		'— اولا — دکتر بلین، و ثانیا — کراوات نزنی هیچ راهی نداره...',
		[[pon(2)]]),

		[6] = _phr('من با کمال میل می‌خوام به درس دکتر بلین گوش بدم!!!',
		'مامور با چشمان بدگمانش من رو ورانداز می‌کنه و با اکرا می‌گه: دعوتنامه‌تون...',
		[[pon(7)]]),

		[7] = _phr('بفرمایید... ما... لطفا...', 'باشه... بیا تو، عجله کن... سمینار شروع شده...',
		[[inv():del('invite'); return walk('hall42')]]);
	},
	exit = function(s,w)
		s:pon(1);
	end
};

hall42 = room {
	nam = 'Hall 2',
	pic = 'gfx/hall2.png',
	dsc = 'کلی آدم. ساکت. به نظرم سمینار در حال اجراست.',
	obj = {
		vobj(1, 'Belin', 'یه مرد کنار تخته ایستاده - {بلینه}! مردی که گربه‌ی من رو دزدیده.'),
		vobj(2, 'seats', 'تعدادی {صندلی} خالی تو ردیف سوم می‌بینم.'),
		vobj(3, 'window', 'سه تا {پنجره} پهن غربی.'),
		vobj(4, 'lamps', 'سالن با نور {لامپ‌های مهتابی} روشن شده.'), 
	},
	act = function(s, w)
		if w == 1 then
			return 'الان کت و کلاه نداره و می‌تونم با دقت وراندازش کنم... حسابی چاق اما قدبلنده... یه لبخند فریبنده و صورت گشاده داره... داره درس می‌ده. منتظر می‌شم تا تموم کنه و سعی می‌کنم باهاش حرف بزنم...';
		end
		if w == 2 then
			return walk('lection');
		end
		if w == 3 then
			return ' بیرون تاریکه... تنها می‌شه گه گاه دونه‌های سفید برف رو تو نور فلورسنت دید.';
		end
		if w == 4 then
			return 'شش تا لامپ... از این نور سوسوزن متنفرم...';
		end
	end,
	exit = function(s, t)
		if t == 'cor4' then
			return 'نمی‌خوام دوباره بلین رو گم کنم...', false;
		end
	end,
	enter = function(s, f)
		if f == 'facectrl' then
			return 'وارد تالار سمینار می‌شم...';
		end
		if not galstuk._wear then
			facectrl:pon(5);
			facectrl:poff(1);
		end
		if not me()._brit or not galstuk._wear then
			return cat(
'سعی می‌کنم وارد تالار بشم، اما یه مرد یونیفرم‌پوش متوقفم می‌کنه. روی اتیکت لباسش نوشته: <<SECURITY>>. یه شاتگان دستشه.^^', walk('facectrl')), false;
		end
		facectrl:poff(1, 5);
		facectrl:pon(6);
		return walk('facectrl'), false;
	end,
	way = { 'cor4' },
};

hall41 = room {
	nam = 'Hall 1',
	dsc = [[وارد تالار خالی می‌شم. به نظر میاد یکی از کلاس‌های درس باشه. ردیف ردیف صندلی ارتفاعشون زیاد می‌شه تا در نهایت به سقف می‌رسن.]],
	pic = 'gfx/hall1.png',
	act = function(s, w)
		if w == 1 then
			return 
'در حال نگاه به تاریکی شب باریسک رو با غم مالیخولیایی به خاطر میارم...';
		end
		if w == 2 then
			return 'ما عین اینها رو یه زمانی تو موسسه‌مون داشتیم، من... ولش کن...';
		end
		if w == 3 then
			return 'هر چیزی که می‌تونستم به خاطر بیارم - فراموش کردم.';
		end
	end,
	obj = {
		vobj(1, 'windows', 'سه تا {پنجره} بزرگ غربی..'),
		vobj(2, 'table', 'یه {میز} بلند کنار تخته قرار داره.'),
		vobj(3, 'board', 'تعدادی معادله از درس قبلی روی {تخته} موندن.'),
		'portrait',
	},
	way = {
		'cor4',
	},
};

cor4 = room {
	nam = '4th floor corridor',
	pic = 'gfx/cor4.png',
	dsc = 'تو راهرو هستم. سقفش خیلی بلنده. سرویس بهداشتی رو تو انتهای راهرو می‌بینم. کف راهرو فرش سبزرنگه.',
	act = function(s, w)
		if not tonumber(w) then
			return;
		end
		if w == 11 then
			return 'بعضی‌هاشون می‌رن به تالار شماره دو.';
		end
		if w == 1 then
			return 'با حالتی مالیخولیایی به تاریکی نگاه می‌کنم... می‌فهمم که چقدر خسته‌ام... اما باید ادامه بدم...';
		end
		if w == 12 then
			return 'این در هم مثل خیلی دیگه از درها یک کارتخوان داره. چراغ قرمز روشنه.';
		end
		if tonumber(w) >=5 and tonumber(w) <=9 then
			room4x._num = w - 4;
			return walk('room4x');
		end
		if w == 10 then
			ways():add('room46');
			return walk('room46');
		end
		if w == 2 then
			ways():add('hall41');
			return walk('hall41');
		end
		if w == 3 then
			ways():add('hall42');
			return walk('hall42');
		end
	end,
	used = function(s, w, ww)
		if w == 12 and ww == 'card' then
			return 
			'کارت رو می‌کشم رو کارتخوان... بیپ... دسترسی ممنوع...';
		end
	end,
	obj = {
	vobj(1, 'window', 'یه {پنجره} جنوبی.'),
	vobj(2, 'hall 1','در ضلع غربی دو تا دروازه پهن می‌بینم: {تالار ۱},'),
	vobj(3, 'hall 2', '{تالار ۲}.'),
	vobj(5, 'lecture room 1', 'در ضلع شرقی درهایی با پهنای کمتر هستن. اتیکت روی درها: {اتاق درس ۱},'),
	vobj(6, 'lecture room 2', '{اتاق درس ۲},'),
	vobj(7, 'lecture room 3', '{اتاق درس ۳},'),
	vobj(8, 'lecture room 4', '{اتاق درس ۴},'),
	vobj(9, 'lecture room 5', '{اتاق درس ۵},'),
	vobj(10, 'lecture room 6', '{اتاق درس ۶}.'),
	vobj(11, 'people', 'گه‌گاه {آدم‌هایی} تو راهرو ظاهر می‌شن.'),
	vobj(12, 'front door', '{درب} جلویی در منتها الیه شمالی راهرو قرار گرفته.'),
	'portrait',
	},
	way = {
		'toilet',
		'toiletw',
	}
};
floor4 = room {
	nam = '4th floor site',
	pic = 'gfx/floor4.png',
	dsc = 'طبقه چهارم سقف بلندی داره.',
	act = function(s, w)
		if w == 1 then
			return 'تاریکی... بدون حتی یک چراغ... حتی ستاره‌ها رو نمی‌تونم ببینم. نور مهتابی سنگین و محو نمی‌ذاره ببینمشون...';
		end
		if w == 2 then
			return 'از آسانسورها بدم میاد...';
		end
		if w == 3 or w == 4 then
			return 'یه در معمولی. یکی از بسیار درهای این ساختمان. یه قفل الکترونیکی. بدون کارت نمی‌تونم داخل بشم.';
		end
	end,
	used = function(s, w, ww)
		if ww == 'card' then
			if w == 3 or w == 4 then
				return [[کارت رو می‌کشم روی کارتخوان... بیپ. دسترسی ممنوع...]];
			end
		end
	end,
	obj = {
		vobj(1, 'window','یه {پنجره} پهن غربی.'),
		vobj(2, 'elevators', 'محوطه چهار {آسانسور} به زحمت روشنه.'),
		vobj(3, 'south door', 'دو در به راهروهای شمالی و جنوبی منتهی می‌شن. اتیکت {درب} جنوبی: <<طبقه: ۴ رده:فیزیک نظری>>'),
		vobj(4, 'north door', 'اتیکت {درب} شمالی: <<طبقه: ۴ رده:بیولوژی>>'),
	},
	way = { 'lift' },
};

floor5 = room {
	nam = '5th floor site',
	pic = 'gfx/floor5.png',
	dsc = [[سقف طبقه پنجم بسیار بلنده.]],
	act = function(s, w)
		if w == 1 then
			return 'پاهام تو مخمل قرمز داره غرق می‌شه... باید مواظب باشم رد پا اینجا از خودم باقی نذارم...';
		end
		if w == 2 then
			return 'آره، از کریستال ساخته شده. امکان نداره شیشه باشه.';
		end
		if w == 3 then
			return 'به طرف پنجره می‌رم... جالبه. می‌بینم که پنجره رو بخش وسیعی از سقفه که در بخش جلویی ساختمون امتداد داره...';
		end
		if w == 4 or w == 5 then
			return 'به خاطر نگهبان نمی‌تونم درها رو وارسی کنم... کارت شناسایی من اینجا معتبر نیست...';
		end
		if w == 6 then
			return 'هرچند هیچ اهمیتی به من نمی‌ده، بازم بهتره که کاری به کارش نداشته باشم...';
		end
	end,
	used = function(s, w)
		if not tonumber(w) then
			return
		end
		if w == 6 then
			return 'بهتره کاری به کارش نداشته باشم...';
		end
		if w >=1 and w <=5 then
			return 'وقتی که نگهبان اینجاست انجامش نمی‌دم،';
		end
	end,
	obj = {
	vobj(1, 'carpet', 'کف با {فرش} قرمز پوشیده شده.'),
	vobj(2, 'chandelier', 'یه {چلچراغ} کریستال بالای سرمه.'),
	vobj(3, 'window', 'یه {پنجره} پهن غربی.'),
	vobj(4, 'information', 'دو تا در می‌بینم که به راهروهای جنوبی و شمالی منتهی می‌شن. اتیکت {درب} جنوبی: <<طبقه: ۵ رده:اطلاعات>>.'),
	vobj(5, 'red door', '{درب} شمالی هیچ اتیکتی نداره. یه در عظیمه که با چرم قرمز پوشونده شده.'),
	vobj(6, 'guard', 'راه منتهی به درها توسط یک اتاقک نگهبانی و یک {نگهبان} مسدود شده.');
	},
	way = { 'lift' },
};

