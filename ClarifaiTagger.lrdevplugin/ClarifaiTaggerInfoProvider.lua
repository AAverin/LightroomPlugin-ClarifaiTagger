local LrView = import 'LrView'

local simpleJsonAcknowledgement = 'Simple JSON encoding and decoding in pure Lua.\n\nCopyright 2010-2014 Jeffrey Friedl\nhttp://regex.info/blog/\n\nLatest version: http://regex.info/blog/lua/json\n\nThis code is released under a Creative Commons CC-BY "Attribution" License:\nhttp://creativecommons.org/licenses/by/3.0/deed.en_US'

-----------------------------------------
local ClarifaiTaggerInfoProvider = {}

function ClarifaiTaggerInfoProvider.sectionsForTopOfDialog(viewFactory, propertyTable)
   local prefs = import 'LrPrefs'.prefsForPlugin(_PLUGIN.id)
   local bind = LrView.bind
   local share = LrView.share

   return {
      {
         title = LOC '$$$/ClarifaiTagger/Settings/AuthHeader=Authentication Settings',

         viewFactory:row {
            spacing = viewFactory:label_spacing(),

            viewFactory:static_text {
               tooltip = "Copy from the setup page on Clarifai.com for your Clarifai application.",
               title = LOC '$$$/ClarifaiTagger/Settings/ClientId=Client ID:',
               alignment = 'right',
               -- width = share 'title_width',
            },

            viewFactory:edit_field {
               tooltip = "Copy from the setup page on Clarifai.com for your Clarifai application.",
               fill_horizonal = 1,
               width_in_chars = 35,
               alignment = 'left',
               value = bind { key = 'clientId', object = prefs },
            },
         },

         viewFactory:row {
            spacing = viewFactory:label_spacing(),

            viewFactory:static_text {
               tooltip = "Copy from the setup page on Clarifai.com for your Clarifai application.",
               title = LOC '$$$/ClarifaiTagger/Settings/clientSecret=Client Secret:',
               alignment = 'right',
               -- width = share 'title_width',
            },

            viewFactory:edit_field {
               tooltip = "Copy from the setup page on Clarifai.com for your Clarifai application.",
               fill_horizonal = 1,
               width_in_chars = 35,
               alignment = 'left',
               value = bind { key = 'clientSecret', object = prefs },
            },
         },

         viewFactory:row {
            spacing = viewFactory:label_spacing(),

            viewFactory:static_text {
               title = LOC '$$$/ClarifaiTagger/Settings/AccessToken=Access Token:',
               alignment = 'right',
               -- width = share 'title_width',
            },

            viewFactory:edit_field {
               fill_horizonal = 1,
               width_in_chars = 35,
               alignment = 'left',
               enabled = false,
               value = bind { key = 'accessToken', object = prefs },
            },
         },

         -- viewFactory:separator { fill_horizontal = 1 },
      },

      {
         title = LOC '$$$/ClarifaiTagger/Settings/tagging=Tagging',

         viewFactory:row {
            spacing = viewFactory:control_spacing(),

            viewFactory:checkbox {
               title = LOC '$$$/ClarifaiTagger/Settings/boldExistingKeywords=Show existing keywords in bold',
               tooltip = "Selecting this option will display in bold print any keywords which are already found in your keyword list",
               value = bind { key = 'boldExistingKeywords', object = prefs },
            },
         },
         viewFactory:row {
            spacing = viewFactory:control_spacing(),

            viewFactory:checkbox {
               title = LOC '$$$/ClarifaiTagger/Settings/autoSelectExistingKeywords=Automatically Select Existing Keywords',
               tooltip = "Selecting this option will auto-select keyword checkboxes which would *not* create a new term in your keyword list.",
               value = bind { key = 'autoSelectExistingKeywords', object = prefs },
            },
         },
         -- Probability threshold (only used if autoSelectExistingKeywords is turned on.)
         viewFactory:row {
            -- spacing = viewFactory:control_spacing(),
            spacing = viewFactory:label_spacing(),

            viewFactory:static_text {
               title = LOC '$$$/ClarifaiTagger/Settings/autoSelectProbabilityThreshold=Probability threshold for auto-selection:',
               alignment = 'left',
               width = share 'title_width',
            },

            viewFactory:slider {
               min = 1,
               max = 99,
               integral = true,
               alignment = 'left',
               value = bind { key = 'autoSelectProbabilityThreshold', object = prefs },
            },

            viewFactory:edit_field {
               fill_horizonal = 1,
               width_in_chars = 2,
               min = 1,
               max = 99,
               increment = 1,
               precision = 0,
               alignment = 'left',
               tooltip = 'Setting for what level of Clarifai-rated probability is required for a keyword to be auto-selected.\n\nIgnored unless the "Auto-Select existing keywords" setting is selected.',
               value = bind { key = 'autoSelectProbabilityThreshold', object = prefs },
            },
         },
         
         viewFactory:row {
            spacing = viewFactory:control_spacing(),

            viewFactory:checkbox {
               title = LOC '$$$/ClarifaiTagger/Settings/showProbability=Show Probability',
               tooltip = "Selecting this will display Clarifai's level of certainty that a keyword is accurate.",
               value = bind { key = 'showProbability', object = prefs },
            },
         },

         viewFactory:row {
            spacing = viewFactory:label_spacing(),

            viewFactory:static_text {
               title = LOC '$$$/ClarifaiTagger/Settings/ignore_keyword_branches=Ignore keywords branches:',
               tooltip = 'Comma-separated list of keyword terms to ignore (including chilren and descendants).',
               alignment = 'left',
               width = share 'title_width',
            },

            viewFactory:edit_field {
               tooltip = 'Comma-separated list of keyword terms to ignore (including chilren and descendants).',
               width_in_chars = 35,
               height_in_lines = 4,
               enabled = true,
               alignment = 'left',
               value = bind { key = 'ignore_keyword_branches', object = prefs },
            },
         },
      },

      {
         title = LOC '$$$/ClarifaiTagger/Settings/imageHeader=Image Settings',

         viewFactory:row {
            spacing = viewFactory:control_spacing(),

            viewFactory:static_text {
               title = LOC '$$$/ClarifaiTagger/Settings/imageSize=Image size:',
               alignment = 'left',
               width = share 'title_width',
            },

            viewFactory:slider {
               min = 224,
               max = 1024,
               integral = true,
               alignment = 'left',
               tooltip = 'Allowable range 224 to 1024 pixels. Higher values use more bandwidth, but may deliver more accurate results.',
               value = bind { key = 'imageSize', object = prefs },
            },

            viewFactory:edit_field {
               fill_horizonal = 1,
               width_in_chars = 4,
               min = 224,
               max = 1024,
               increment = 1,
               precision = 0,
               alignment = 'left',
               tooltip = 'Allowable range 224 to 1024 pixels. Higher values use more bandwidth, but may deliver more accurate results.',
               value = bind { key = 'imageSize', object = prefs },
            },
         },

         viewFactory:row {
            viewFactory:spacer { width = share 'title_width', height = 1 },

            viewFactory:static_text {
               title = LOC '$$$/ClarifaiTagger/Settings/ThumbnailSizeDesc=Size of image sent to the Clarifai server',
               alignment = 'right',
            },
         },
         viewFactory:spacer { width = 1, height = 4 },

         viewFactory:row {
            spacing = viewFactory:label_spacing(),

            viewFactory:static_text {
               title = LOC '$$$/ClarifaiTagger/Settings/keywordLanguage=Keyword language:',
               alignment = 'left',
               width = share 'title_width',
            },

            viewFactory:popup_menu {
               items = {
                  { value = ''      , title = 'Default (depends on the server setting)' },
                  { value = 'ar'    , title = 'Arabic (ar)'                  },
                  { value = 'bn'    , title = 'Bengali (bn)'                 },
                  { value = 'da'    , title = 'Danish (da)'                  },
                  { value = 'de'    , title = 'German (de)'                  },
                  { value = 'en'    , title = 'English (en)'                 },
                  { value = 'es'    , title = 'Spanish (es)'                 },
                  { value = 'fi'    , title = 'Finnish (fi)'                 },
                  { value = 'fr'    , title = 'French (fr)'                  },
                  { value = 'hi'    , title = 'Hindi (hi)'                   },
                  { value = 'hu'    , title = 'Hungarian (hu)'               },
                  { value = 'it'    , title = 'Italian (it)'                 },
                  { value = 'ja'    , title = 'Japanese (ja)'                },
                  { value = 'ko'    , title = 'Korean (ko)'                  },
                  { value = 'nl'    , title = 'Dutch (nl)'                   },
                  { value = 'no'    , title = 'Norwegian (no)'               },
                  { value = 'pa'    , title = 'Punjabi (pa)'                 },
                  { value = 'pl'    , title = 'Polish (pl)'                  },
                  { value = 'pt'    , title = 'Portuguese (pt)'              },
                  { value = 'ru'    , title = 'Russian (ru)'                 },
                  { value = 'sv'    , title = 'Swedish (sv)'                 },
                  { value = 'tr'    , title = 'Turkish (tr)'                 },
                  { value = 'zh-TW' , title = 'Chinese Traditional (zh-TW)'  },
                  { value = 'zh'    , title = 'Chinese Simplified (zh)'      },
               },
               value = bind { key = 'keywordLanguage', object = prefs },
            },
         },
      }
   }
end


function ClarifaiTaggerInfoProvider.sectionsForBottomOfDialog(viewFactory, propertyTable)
   local KwUtilsAttribution = require 'KwUtils'.Attribution
   local LutilsAttribution = require 'LUTILS'.Attribution
   return {
      {
         title = LOC '$$$/ClarifaiTagger/Settings/acknowledgements=Acknowledgements',
         viewFactory:static_text {
            title = LOC '$$$/ClarifaiTagger/Settings/simpleJSON=Simple JSON',
         },
         viewFactory:edit_field {
            width_in_chars = 80,
            height_in_lines = 9,
            enabled = false,
            value = simpleJsonAcknowledgement
         },
         viewFactory:static_text {
            title = LOC '$$$/ClarifaiTagger/Settings/KwUtils=KwUtils: Keyword Utility Functions for Lightroom',
         },
         viewFactory:edit_field {
            width_in_chars = 80,
            height_in_lines = 5,
            enabled = false,
            value = KwUtilsAttribution
         },
         viewFactory:static_text {
            title = LOC '$$$/ClarifaiTagger/Settings/Lutils=LUTILS: Lua Utility Functions for Lightroom',
         },
         viewFactory:edit_field {
            width_in_chars = 80,
            height_in_lines = 5,
            enabled = false,
            value = LutilsAttribution
         }
      }
   }
end


return ClarifaiTaggerInfoProvider

