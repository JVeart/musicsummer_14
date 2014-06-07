class AddFestFieldsAndData < ActiveRecord::Migration
  def change
    add_column :festivals, :location, :string
    add_column :festivals, :twitter, :string
    add_column :festivals, :facebook, :string
    add_column :festivals, :draugiem, :string
    add_column :festivals, :homepage, :string
    add_column :festivals, :lineup_link, :string
    
    
    festivals =
    [
      {
        :name=>'Rīgas Operas Festivāls',
        :start_date=>'2014-06-03',
        :end_date=>'2014-06-15',
        :lineup_link=>'http://www.opera.lv/lv/festivals/rof-2014/'
      },
      {
        :name=>'Urban Poetry/FreeRiga',
        :start_date=>'2014-06-03',
        :end_date=>'2014-06-08',
        :lineup_link=>'https://www.facebook.com/events/632295916865329/'
      },
      {
        :name=>'Motociklistu vasara',
        :start_date=>'2014-06-07',
        :end_date=>'2014-06-07',
        :lineup_link=>'http://www.mca.lv/calendar.php?l=1&show=285'
      },
      {
        :name=>'Lielā roka nakts',
        :start_date=>'2014-06-07',
        :end_date=>'2014-06-07',
        :lineup_link=>'http://www.bilesuserviss.lv/lat/biletes/valkasvalgas-liela-roka-nakts-144400/#'
      },
      {
        :name=>'Piens Fest Ziemeļblāzma',
        :start_date=>'2014-06-08',
        :end_date=>'2014-06-08',
        :lineup_link=>'http://piens.nu/fest/'
      },
      {
        :name=>'Solstice Yoga Festival',
        :start_date=>'2014-06-20',
        :end_date=>'2014-06-22',
        :lineup_link=>'http://www.solsticeyogafestival.com/lat/skolotaji_un_muziki'
      },
      {
        :name=>'Rīgas Festivāls',
        :start_date=>'2014-04-26',
        :end_date=>'2014-06-22',
        :lineup_link=>'http://www.rigasfestivals.lv/lv/programme'
      },
      
      
      {
        :name=>'Rīgas Ritmi',
        :start_date=>'2014-07-03',
        :end_date=>'2014-07-05',
        :lineup_link=>'http://www.rigasritmi.lv/lv/makslinieki/2014'
      },
      {
        :name=>'Pagalms',
        :start_date=>'2014-07-04',
        :end_date=>'2014-07-05',
        :lineup_link=>'https://www.facebook.com/PagalmsFest'
      },
      {
        :name=>'Leukadionīsa planetārijs',
        :start_date=>'2014-07-05',
        :end_date=>'2014-07-05',
        :lineup_link=>'http://leukadioniss.wordpress.lv/2012-muziki/'
      },
      {
        :name=>'Jūrmalas Džeza Festivāls',
        :start_date=>'2014-07-06',
        :end_date=>'2014-07-06',
        :lineup_link=>'http://www.livefest.lv/index_details/i/14'
      },
      {
        :name=>'Senās mūzikas festivāls',
        :start_date=>'2014-07-08',
        :end_date=>'2014-07-12',
        :lineup_link=>'http://www.smf.lv'
      },
      {
        :name=>'Cēsu Mākslas Festivāls',
        :start_date=>'2014-07-11',
        :end_date=>'2014-08-09',
        :lineup_link=>'http://www.cesufestivals.lv/'
      },
      {
        :name=>'Summer Sound',
        :start_date=>'2014-07-11',
        :end_date=>'2014-07-12',
        :lineup_link=>'http://www.summersound.lv/lv/makslinieki'
      },
      {
        :name=>'Bauskas kantrī mūzikas festivāls',
        :start_date=>'2014-07-11',
        :end_date=>'2014-07-12',
        :lineup_link=>'http://countrybauska.lv/'
      },
      {
        :name=>'Rupjmaize',
        :start_date=>'2014-07-11',
        :end_date=>'2014-07-13',
        :lineup_link=>'https://www.facebook.com/events/1450301585213682'
      },
      {
        :name=>'Positivus',
        :start_date=>'2014-07-18',
        :end_date=>'2014-07-20',
        :lineup_link=>'https://www.positivusfestival.com/lv/line-up22/all'
      },
      {
        :name=>'Saulkrasti Jazz',
        :start_date=>'2014-07-21',
        :end_date=>'2014-07-26',
        :lineup_link=>'http://saulkrastijazz.lv/'
      },
      {
        :name=>'Jaunais vilnis',
        :start_date=>'2014-07-22',
        :end_date=>'2014-07-27',
        :lineup_link=>'http://www.newwavestars.com/ru/'
      },
      {
        :name=>'Give & Get',
        :start_date=>'2014-07-24',
        :end_date=>'2014-07-27',
        :lineup_link=>'http://www.giveandget.lv/lv'
      },
      {
        :name=>'Shine Cafe',
        :start_date=>'2014-07-25',
        :end_date=>'2014-07-27',
        :lineup_link=>'http://www.shinecafe.lv/'
      },
      {
        :name=>'Klang Fest',
        :start_date=>'2014-07-25',
        :end_date=>'2014-07-26',
        :lineup_link=>'https://www.facebook.com/events/526037567494616/'
      },
      {
        :name=>'Blūza Svētki',
        :start_date=>'2014-07-26',
        :end_date=>'2014-07-26',
        :lineup_link=>'http://www.bluesfest.lv/'
      },
      {
        :name=>'Ad Lucem',
        :start_date=>'2014-07-26',
        :end_date=>'2014-08-03',
        :lineup_link=>'http://www.adlucem.info/?sadala=15'
      },
      
      
      {
        :name=>'LabaDaba',
        :start_date=>'2014-08-01',
        :end_date=>'2014-08-03',
        :lineup_link=>'http://www.labadaba.lv/makslinieki/'
      },
      {
        :name=>'XXII Starptautiskie Siguldas Opermūzikas svētki',
        :start_date=>'2014-08-01',
        :end_date=>'2014-08-03',
        :lineup_link=>'http://www.opersvetki.lv/lv/makslinieki/'
      },
      {
        :name=>'Return To Surface',
        :start_date=>'2014-08-02',
        :end_date=>'2014-08-03',
        :lineup_link=>'http://www.rts-festival.ucoz.com'
      },
      {
        :name=>'ReReRīga',
        :start_date=>'2014-08-06',
        :end_date=>'2014-08-09',
        :lineup_link=>'http://rereriga.lv/makslinieki/'
      },
      {
        :name=>'Dabas koncertzāles pirmā simfonija',
        :start_date=>'2014-08-09',
        :end_date=>'2014-08-09',
        :lineup_link=>'http://www.dabaskoncerts.lv/'
      },
      {
        :name=>'Summertime',
        :start_date=>'2014-08-08',
        :end_date=>'2014-08-17',
        :lineup_link=>'http://festivalsummertime.com/'
      },
      {
        :name=>'Live Fest',
        :start_date=>'2014-08-15',
        :end_date=>'2014-08-16',
        :lineup_link=>'http://www.livefest.lv/index_details/i/13'
      },
      {
        :name=>'Fontaine Festival',
        :start_date=>'2014-08-15',
        :end_date=>'2014-08-17',
        :lineup_link=>'http://www.fontainefestival.com/artists-profiles/'
      },
      {
        :name=>'17. Starptaustiskais garīgās mūzikas festivāls',
        :start_date=>'2014-08-21',
        :end_date=>'2014-09-06',
        :lineup_link=>'http://koris.lv/festivals/'
      }
      
    ]
    
    festivals.each do |festival|
      Festival.create(festival)
    end
  end
  
  
  
end
