open ReactQuery__QueryClient

module ReactQueryDevtools = struct
  type button_position =
    [ `TopLeft [@as "top-left"]
    | `TopRight [@as "top-right"]
    | `BottomLeft [@as "bottom-left"]
    | `BottomRight [@as "bottom-right"]
    | `Relative [@as "relative"]
    ]

  type position =
    [ `Top [@as "top"]
    | `Bottom [@as "bottom"]
    | `Left [@as "left"]
    | `Right [@as "right"]
    ]

  external make
    :  ?initialIsOpen:bool
    -> ?buttonPosition:button_position
    -> ?position:position
    -> ?client:QueryClient.t
    -> unit
    -> React.element
    = "ReactQueryDevtools"
  [@@mel.module "@tanstack/react-query-devtools"] [@@react.component]
end
