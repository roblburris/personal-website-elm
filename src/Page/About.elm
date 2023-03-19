module Page.About exposing (view)

import Html exposing (..)
import Html.Attributes exposing (src)
import Html.Attributes exposing (height)
import Html.Attributes exposing (width)
import Html.Attributes exposing (size)
import Html.Attributes exposing (class)
import Html.Attributes exposing (style)


  
view : { title : String, content : Html msg}
view =
  { title = "Home"
  , content =
    div []
    [ h1 [] [ text "About Me" ]
    , span [] [
         text
           """
            For a condensed summary of my professional and educational
            experience, refer to my resume. If you're interested in a more
            in depth overview of my current career, look no further!
            """
        ]
    , h2 [] [text "Education"]
    , span [] [text "University of Washington - Seattle, Washington"]
    , br [] []
    , span [] [
        text 
        """
        September 2019 - June 2023
        """
    ]
    , br [] []
    , br [] []
    , span [] [
        text 
            """
            I'm currently in the process of completing my undergraduate studies at the University of Washington (Go Dawgs!  
            """
        , img [
            src "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/University_of_Washington_Purple_Block_W_logo.svg/2560px-University_of_Washington_Purple_Block_W_logo.svg.png"
            , class "logo"
        ] []
        , text
            """
            TODO      
            )! majoring in Computer Science with minors in Art History and Mathematics. I was also an active member of the Psi Upsilon fraternity and involved myself in various clubs. While at UW, I took a variety of classes across a multitude of departments. Here are some of my favorites:
            """
    ]
    , h2 [] [text "Professional Experience"]
    , span [] [text "Incoming Software Engineer @ "]
    , img [
        src "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Palantir_Technologies_logo.svg/2560px-Palantir_Technologies_logo.svg.png"
        , class "logo"] []
    , br [] []
    , span [] [
        text 
        """
        July 2023 - Present
        """
    ]
    , br [] []
    , span [] [
        text 
        """
        I'm super excited to be joining Palantir at the NYC office after graduation!
        """
    ]
    , br [] []
    , br [] []
    , span [] [text "Software Engineer Intern @ "]
    , img [
        src "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1920px-Google_2015_logo.svg.png"
        , class "logo"] []
    , br [] []
    , span [] [
        text 
        """
        June 2022 - September 2022
        """
    ]
    , br [] []
    , span [] [
        text 
        """
        I worked on flex-sre, a Google Cloud Technical Infrastructure SRE team responsible for improving the shared resource allocator for running services across 95% of Google/Alphabet. Within Google, different product areas have assigned resource allocations that are managed through a flexible resource allocator aptly named Flex. For each running job in each of these 'pools' of resources, one can manage its status (scale up, scale down, request a temporary increase in compute) through a cli. This cli was a globalized service with a frontend to route requests to different shards running in Google's many datacenters and before I joined, monitoring only covered the backends meaning  outages with the frontend and cli would go undetected until users noticed. This is particularly bad in the case of users needing to urgently update their resource allocation; for example, imagine a service that needed to urgently scale up to accomdate load and the cli was breaking. Not good!
        """
        , br [] []
        , br [] []
        ,
        text
        """
        Enter my project where I implemented a prober service for the cli. My prober service would run a sample workflow on a certain time interval and report a binary result - PASS/FAIL. If too many failures were noted over a certain period, my prober would send an alert to the active oncaller to allow them to investigate further. As a result, outages can be detected faster thus decreasing mean time to repair and improving user experiences across the board. With my prober service, we were able to increase coverage to 100% and also created an easily deployable prober that could be deployed to various regions and resource pools by simply updating a config file.
        """
    ]
    , br [] []
    , br [] []
    , span [] [text "Software Engineer Intern @ "]
    , img [
        src "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Intuit_Logo.svg/1200px-Intuit_Logo.svg.png"
        , class "logo"] []
    , br [] []
    , span [] [
        text 
        """
        February 2022 - June 2022
        """
    ]
    , br [] []
    , span [] [
        text 
        """
        TODO      
        """
    ]
    ]
  }
      
