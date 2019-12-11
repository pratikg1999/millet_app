/// Server's IP address
String serverIP =
    "192.168.137.1"; //"104.237.9.77";//"";//"10.196.22.121"; //"104.237.9.77"; //

/// Server's port address
String serverPort = "8000";

final Map<String, String> smut = {
  "Disease": 'Smut',
  "About":
      """Reported for the first time by Kulkarni (1922) from Malkapur in 1918 from the then princely state of Kolhapur.""",
  "Symptoms":
      "The affected ovaries are transformed in to velvety greenish gall like bodies which are several times bigger in size than the normal healthy grains (Fig. 5). These infected grains gradually turn pinkish green and finally to dirty black on drying. ",
  "Causal Fungus": "Melanopsichium eleusinis",
  "Control":
      """Seed treatment with Carbendazim @ 2g/kg-1 of seed.Two sprays, the first with Difolatan at panicle initiation followed by second spray with mancozeb at flowering can reduce disease incidence
  Seed treatment with Carbendazim or Thiram @ 2 g/kg seed before sowing. Use of resistant varieties like PRJ 1
  """,
};

final Map<String, String> rust = {
  "Disease": 'Rust',
  "About":
      """ This diseaseon finger millet as of now is negligible albeit. Severe incidence of rust was reported from Agricultural Research Station, Vizianagaram, Andhra Pradesh on various varieties. """,
  "Symptoms":
      """The rust symptoms appear as minute to small, dark brown, broken pustules linearly arranged on the upper surface of the top leaves. The rust is more severe towards the top 1/3 portion of the upper leaf.""",
  "Causal Fungus": """Uromyces eragrostidis""",
  "Control":
      """  Growing of resistant varieties viz., SEC 915, 314, 712 and ICMV-221 """,
};

final Map<String, String> ergot = {
  "Disease": 'Ergot',
  "About":
      """It causes direct grain yield loss by replacing grains with toxic alkaloid-containing sclerolia, making the produce unfit tor consumption.""",
  "Symptoms":
      """The ergot causing fungus infects the florets and develops in the ovaries, producing initially copious creamy, pink, or red colored sweet sticky liquid called honey dew.""",
  "Causal Fungus": """Claviceps fusiformis""",
  "Control": """A. Cultural control
Deep ploughing soon after harvest helps bury sclerotia in a soil at a depth which prevents their germination, thus reducing primary inoculum. Separate infested seed from normal seed by soaking in 10% salt solution. Floating light weight infested seeds are separated from normal grain which sinks to the bottom. In India, two perennial grass weeds Cenchrus ciliaris and Panicum antidotale were found to harbor the pearl millet ergot fungus.
Eradicating these two weeds from around pearl millet fields during early May / June might help reduce the inoculum.


B. Host –plant Resistance
Use of resistant cultivars is the most cost-effective method for the control of Ergot Disease. Four open pollinated varieties, WC-C75, ICMS 7703, ICTP 8203, and ICMV 155 released in India are resistant to Ergot Disease.
""",
};

final Map<String, String> bacterial = {
  "Disease": 'Bacterial',
  "About":
      """The diseases caused by this bacterium are very important throughout the world.""",
  "Symptoms":
      """The symptoms first appear on the lower sides of the leaves as small, water-soaked spots. The spots enlarge, coalesce, and form larger areas that later become necrotic. The bacteria also enter the vascular tissues of the leaf and spread into the stem. The infected area, which is surrounded by a narrow zone of bright, lemon yellow tissue, turns brown, becomes rapidly necrotic, and through coalescence of several small spots, may produce large dead areas of various shapes. The disease produces identical symptoms on the stems, pods and seeds. In addition, light-cream or silver bacterial exudates are often produced on the lesions under moist conditions.""",
  "Causal": """Bacteria""",
  "Control": """No suitable seed treatment to eradicate infection""",
};

final Map<String, Map> diseases = {
  "smut": smut,
  "rust": rust,
  "ergot": ergot,
  "bacterial": bacterial
};
