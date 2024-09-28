include ReactQuery__QueryClient
include ReactQuery__DevTools

module QueryClient = struct
  type t

  external make : unit -> t = "QueryClient"
  [@@mel.module "@tanstack/react-query"]
end

module QueryDevtools = struct
  external make : unit -> React.element = "ReactQueryDevtools"
  [@@mel.module "@tanstack/react-query-devtools"]
end

external keepPreviousData : 'a = "keepPreviousData"
[@@mel.module "@tanstack/react-query"]

type network_mode =
  [ `online
  | `always
  | `offlineFirst
  ]

type 'data placeholder_data =
  | Data of 'data
  | Function

type retry =
  | Bool of bool
  | Int of int
  | Function of (int -> bool)

type retry_delay =
  | Int of int
  | Function of (int -> float)

type abort_signal
type query_fn_params = { signal : abort_signal }

type 'data query_options =
  { queryKey : string array
  ; queryFn : unit -> 'data Js.Promise.t
  ; staleTime : int option
  ; retry : retry option
  ; retryDelay : retry_delay option
  ; networkMode : network_mode option
  ; enabled : bool option
  ; refetchOnWindowFocus : bool option
  ; initialData : 'data option
  ; placeholderData : 'data placeholder_data option
  }

type ('data, 'selectedData) query_options_with_select =
  { queryOptions : 'data query_options
  ; select : 'data -> 'selectedData
  }

type status =
  [ `pending
  | `error
  | `success
  ]

type fetch_status =
  [ `fetching
  | `paused
  | `idle
  ]

type 'data query_state =
  { isPending : bool
  ; isError : bool
  ; isSuccess : bool
  ; isFetching : bool
  ; status : status
  ; fetchStatus : status
  ; data : 'data
  ; error : Js.Exn.t option
  ; refetch : unit -> 'data query_state Js.Promise.t
  }

type 'data use_queries_options = { queries : 'data query_options array }

let make_query
  ~queryKey
  ~queryFn
  ?staleTime
  ?retry
  ?retryDelay
  ?networkMode
  ?enabled
  ?refetchOnWindowFocus
  ?initialData
  ?placeholderData
  ()
  =
  { queryKey
  ; queryFn
  ; staleTime
  ; retry
  ; retryDelay
  ; networkMode
  ; enabled
  ; refetchOnWindowFocus
  ; initialData
  ; placeholderData
  }
;;

external useQuery : 'data query_options -> 'data query_state = "useQuery"
[@@mel.module "@tanstack/react-query"]

external useSuspenseQuery
  :  'data query_options
  -> 'data query_state
  = "useSuspenseQuery"
[@@mel.module "@tanstack/react-query"]

external useQueryWithSelect
  :  ('data, 'selectedData) query_options_with_select
  -> 'selectedData query_state
  = "useQuery"
[@@mel.module "@tanstack/react-query"]

external useQueries
  :  'data use_queries_options
  -> 'data query_state array
  = "useQueries"
[@@mel.module "@tanstack/react-query"]

type ('params, 'data, 'error, 'context) use_mutation_options =
  { mutationFn : 'params -> 'data Js.Promise.t
  ; retry : retry option
  ; retryDelay : retry_delay option
  ; onMutate : ('params -> 'context Js.Promise.t) option
  ; onError : ('error -> 'params -> 'context -> unit) option
  ; onSuccess : ('data -> 'params -> 'context -> unit) option
  ; onSettled : ('data -> 'error -> 'params -> 'context -> unit) option
  }

type mutation_status =
  [ `error
  | `pending
  | `idle
  | `success
  ]

type ('params, 'data, 'error, 'context) mutation_state =
  { isPending : bool
  ; isError : bool
  ; isSuccess : bool
  ; isFetching : bool
  ; status : mutation_status
  ; reset : unit -> unit
  ; onError : 'error -> 'params -> 'context -> unit
  ; onSuccess : 'data -> 'params -> 'context -> unit
  ; onSettled : 'data -> 'error -> 'params -> 'context -> unit
  ; mutate : 'params -> unit
  ; mutateAsync : 'params -> 'data Js.Promise.t
  }

external useMutation
  :  ('params, 'data, 'error, 'context) use_mutation_options
  -> ('params, 'data, 'error, 'context) mutation_state
  = "useMutation"
[@@mel.module "@tanstack/react-query"]

module QueryErrorResetBoundary = struct
  type render_props = { reset : unit -> unit }

  external make
    :  children:(render_props -> React.element)
    -> React.element
    = "QueryErrorResetBoundary"
  [@@mel.module "@tanstack/react-query"]
end

external useQueryErrorResetBoundary
  :  unit
  -> QueryErrorResetBoundary.render_props
  = "useQueryErrorResetBoundary"
[@@mel.module "@tanstack/react-query"]
