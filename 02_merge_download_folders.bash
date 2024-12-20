
# check that the file names are unique in the main folder and the folder of repeated samples
# no output means there are no duplicated filenames:
find /gpfs01/home/mbzlld/data/stickleback -type f -printf '%p/ %f\n' | sort -k2 | uniq -f1 --all-repeated=separate


# check if the repeat folder names match the original folder names
# they do


# once you are sure the file names are unique move the contents of the repeats into the main folder


# Get the list of folders with the following command:
cd /gpfs01/home/mbzlld/data/stickleback/Trimmed2
ls -d Sample_* | cut -d' ' -f10 | sed 's/$/" /' | sed 's/^/"/' | tr -d '\n'

## declare your list of folders in the second dataset as an array variable
declare -a arr=("Sample_1-22A001" "Sample_2-22A002" "Sample_3-22A003" "Sample_4-22A004" "Sample_5-22A005" "Sample_7-22A007" "Sample_8-22A008" "Sample_10-22A010" "Sample_11-22A011" "Sample_12-22A012" "Sample_13-22A013" "Sample_14-22A014" "Sample_15-22A015" "Sample_16-22A016" "Sample_17-22A017" "Sample_18-22A018" "Sample_19-22A019" "Sample_20-22A020" "Sample_21-22A021" "Sample_22-22A022" "Sample_23-22A023" "Sample_24-22A024" "Sample_25-22H001" "Sample_26-22H002" "Sample_27-22H003" "Sample_28-22H004" "Sample_30-22H006" "Sample_31-22H007" "Sample_32-22H008" "Sample_33-22H009" "Sample_34-22H010" "Sample_35-22H011" "Sample_37-22H013" "Sample_38-22H014" "Sample_39-22H015" "Sample_40-22H016" "Sample_42-22H018" "Sample_43-22H019" "Sample_44-22H020" "Sample_45-22H021" "Sample_46-22H022" "Sample_47-22H023" "Sample_53-NOVSC009" "Sample_62-NOVSC037" "Sample_67-NOVSC043" "Sample_70-Ice22027" "Sample_71-Ice22028" "Sample_75-Ice22041" "Sample_83-mara22044" "Sample_85-alm222075" "Sample_88-anso22103" "Sample_95-22A025" "Sample_103-22A033" "Sample_104-22A034" "Sample_107-22A037" "Sample_108-22A038" "Sample_109-22A039" "Sample_111-22A041" "Sample_113-22A043" "Sample_114-22A044" "Sample_115-22A045" "Sample_116-22A046" "Sample_117-22A047" "Sample_118-22A048" "Sample_119-22A049" "Sample_121-22H025" "Sample_123-22H027" "Sample_124-22H028" "Sample_125-22H029" "Sample_126-22H030" "Sample_128-22H032" "Sample_129-22H033" "Sample_131-22H035" "Sample_133-22H037" "Sample_134-22H038" "Sample_136-22H040" "Sample_137-22H041" "Sample_138-22H042" "Sample_141-22H045" "Sample_148-NOVSC102" "Sample_150-NOVSC104" "Sample_151-NOVSC105" "Sample_153-NOVSC107" "Sample_154-NOVSC108" "Sample_155-NOVSC109" "Sample_157-NOVSC111" "Sample_159-NOVSC114" "Sample_161-NOVSC116" "Sample_163-NOVSC118" "Sample_164-NOVSC119" "Sample_166-Ice22046" "Sample_167-Ice22047" "Sample_168-Ice22048" "Sample_169-Ice22049" "Sample_174-cape22023" "Sample_180-alm222070" "Sample_184-coru22127" "Sample_185-coru22129" "Sample_190-Uist22510" "Sample_191-Uist22524" "Sample_202-Uist22565" "Sample_205-Uist22502" "Sample_206-Uist22512" "Sample_209-Uist22554" "Sample_216-Uist22539" "Sample_219-Ice22009" "Sample_225-Uist22556" "Sample_244-Ice22015" "Sample_248-Uist22547" "Sample_251-Ice22016" "Sample_254-Uist22520" "Sample_265-Uist22561" "Sample_279-Uist22535" "Sample_287-Uist22640" "Sample_288-Uist22652" "Sample_289-Uist22664" "Sample_292-Uist22605" "Sample_297-Uist22665" "Sample_299-Uist22741" "Sample_301-Uist22618" "Sample_303-Uist22642" "Sample_306-Ice22022" "Sample_308-Uist22607" "Sample_309-Uist22619" "Sample_313-Uist22667" "Sample_314-Ice22024" "Sample_316-Uist22608" "Sample_317-Uist22620" "Sample_318-Uist22632" "Sample_319-Uist22644" "Sample_321-Uist22668" "Sample_323-Ice22032" "Sample_326-Uist22633" "Sample_327-Uist22645" "Sample_330-Ice22033" "Sample_331-Ice22034" "Sample_338-Ice22064" "Sample_342-Uist22635" "Sample_352-Uist22660" "Sample_353-Ice22066" "Sample_354-Ice22067" "Sample_357-Uist22625" "Sample_364-Uist22614" "Sample_396-Uist22688" "Sample_401-Uist22693" "Sample_408-Uist22700" "Sample_431-Uist22CLAM5" "Sample_432-Uist22x81male" "Sample_434-Uist22x83male" "Sample_439-Uist22752" "Sample_443-Uist22x85femae" "Sample_484-Uist22737" "Sample_498-Ice22038" "Sample_499-Ice22054" "Sample_508-Ice22063" "Sample_531-Uist22x90female")

## now loop through the above array and move files from the second folder to the first
# finished in seconds
for i in "${arr[@]}"
do
mv -i /gpfs01/home/mbzlld/data/stickleback/Trimmed2/$i/* /gpfs01/home/mbzlld/data/stickleback/Trimmed1/$i/
done

# remove the now empty second data download directory
#rm -ir Trimmed2/

# rename the now merged directory Trimmed_1 back to Trimmed
mv Trimmed1/ Trimmed


# Now back up the merged Trimmed folder back to Sharepoint

