module QueryClient = struct
  type queryKey = string array

  type queryOptions =
    { queryKey : queryKey
    ; exact : bool option
    }

  type t
  type defaultOptions = { retryDelay : (int -> float) option }
  type queryClientOptions = { defaultOptions : defaultOptions option }

  external make : unit -> t = "QueryClient"
  [@@mel.module "@tanstack/react-query"] [@@mel.new]

  external makeWithOptions : queryClientOptions -> t = "QueryClient"
  [@@mel.module "@tanstack/react-query"] [@@mel.new]

  external invalidateQueries : t -> queryOptions -> unit = "invalidateQueries"
  [@@mel.send]

  external getQueryData : t -> queryKey -> 'queryData option = "getQueryData"
  [@@mel.send]

  external cancelQueries
    :  t
    -> queryOptions
    -> unit Js.Promise.t
    = "cancelQueries"
  [@@mel.send]

  external setQueryData : t -> queryKey -> 'queryData -> unit = "setQueryData"
  [@@mel.send]
end

module QueryClientProvider = struct
  external make
    :  client:QueryClient.t
    -> children:React.element
    -> React.element
    = "QueryClientProvider"
  [@@react.component] [@@mel.module "@tanstack/react-query"]
end

external useQueryClient : unit -> QueryClient.t = "useQueryClient"
[@@mel.module "@tanstack/react-query"]
