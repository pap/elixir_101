# Elixir 101

1. About me
2. Intro
3. Tooling
4. Types & Operators
5. Pattern Matching
6. Modules and Functions
7. Control Flow
8. Processes & Nodes
9. Agents and Tasks

# About me

Paulo A Pereira

- Enginnering Director (Lisbon) at [Onfido](onfido.com)
- Packt Publishing [Elixir Cookbook](https://www.packtpub.com/application-development/elixir-cookbook) author
- Manning [Microservices in Action](https://www.manning.com/books/microservices-in-action) co-author
- Grails, Ruby, Elixir
- Twitter: @odesassossegado
- Personal blog: <http://pap.github.io>
- Onfido blog: <https://medium.com/onfido-tech>

# Intro

## What is Elixir?

* Dynamic functional language running on the Erlang VM
* Inspired by some programming languages as Ruby, Clojure and Erlang
* Allows us to build scalable and maintainable applications
* Processes (lots of them)
* Actor model

## Erlang? What is it and do I need to care about it?

* Erlang was created at Ericsson by by Joe Armstrong, Robert Virding and Mike Williams. The first version was released in 1986
* Elixir allows us to easily interact with existing Erlang libraries/applications
* No need to know Erlang to write Elixir but no harm in knowing about it either

## Isn't Elixir just Erlang with a Ruby-like syntax?

Elixir may have a familiar syntax for the Ruby developer but what really matters is the semantics! There is a huge difference between Ruby and Elixir!

## Let it crash ! Fail fast ! Happy path programming

* When we are dealing with distributed systems things will fail (all the time)
* Sometimes (most actually) the best way to recover from a failure is to start all over again
* Follow the happy path and don't worry about everything that may go wrong

# Tooling

Elixir focused, from the start, in providing the developer with great tooling and lowering (as much as possible) the entry barrier.

### IEx

IEx is a REPL. Allows to run code and, define modules and functions etc.

### Mix

Mix is a build tool that ships with Elixir. With mix we can:
* create applications
* manage dependencies
* implement your own "tasks"

### Hex

[Hex](https://hex.pm) is a package manager for the Erlang ecosystem.

### ExDoc

 ExDoc is a tool to produce HTML and EPUB documentation for Elixir projects.

# Types

- Integer
- Float
- Boolean
- Atom
- Tuple
- List
- (Bit)strings and Binaries
- Pids and Links
- Keyword lists
- Maps
- Anonymous functions

```elixir
iex> 16
16
iex> 0x10
16
iex> 0x10 == 16
true


iex> 3.141592653589793
3.141592653589793


iex> true
true
iex> false
false


iex> :atom
:atom
iex> :another_atom
:another_atom
iex> is_atom :another_atom
true


iex> {"one", 1, :one}
{"one", 1, :one}


iex> list = [1, 2, "three", :four]
[1, 2, "three", :four]
iex> hd list
1
iex> tl list
[2, "three", :four]
iex> [h | t] = list
[1, 2, "three", :four]
iex> h
1
iex> t
[2, "three", :four]


iex> "String!"
"String!"
iex> <<"Also a String!">>
"Also a String!"
iex> """
...> Multi
...> Line
...> String
...> """
"Multi\nLine\nString\n"
iex> string = "AbCçDÉ"
"AbCçDÉ"
iex>String.length string
6
iex> byte_size string
8
iex> String.codepoints("AbCçDÉ")
["A", "b", "C", "ç", "D", "É"]
# more on binaries when we talk about pattern matching!

iex> self()
#PID<0.80.0>
iex> spawn fn -> 5/0 end
#PID<0.61.0>
iex>
15:39:30.082 [error] Error in process <0.61.0> with exit value: {badarith,[{erlang,'/',[5,0],[]}]}

nil
iex> spawn_link fn -> 5/0 end

15:39:51.252 [error] Error in process <0.65.0> with exit value: {badarith,[{erlang,'/',[5,0],[]}]}


** (EXIT from #PID<0.53.0>) an exception was raised:
    ** (ArithmeticError) bad argument in arithmetic expression
        :erlang./(5, 0)

iex> kw_list = [one: 1, two: 2]
[one: 1, two: 2]
iex> kw_list[:one]
1
iex> Keyword.keys kw_list
[:one, :two]
iex> Keyword.values kw_list
[1, 2]
iex> [one: 1, two: 2] == [{:one, 1},{:two, 2}]
true

iex> map = %{one: 1, two: 2}
%{one: 1, two: 2}
iex> map[:one]
1
iex> map[:three]
nil
iex(14)> Map.put(map, :one, 2)
%{one: 2, two: 2}
iex(15)> map
%{one: 1, two: 2}

iex> doubler = fn(x) -> x * 2 end
#Function<6.90072148/1 in :erl_eval.expr/5>
iex> doubler.(5)
10
iex> plus_one = fn(x) -> x + 1 end
#Function<6.90072148/1 in :erl_eval.expr/5>
iex> doubler.(plus_one.(5))
12
iex> plus_one.(doubler.(5))
11
iex> plus_one.(5) |> doubler.()
12
iex> doubler.(5) |> plus_one.()
11
iex> add = &(&1 + &2)
&:erlang.+/2
iex> add.(1,2)
iex> add = fn(x,y) -> x + y end
#Function<12.90072148/2 in :erl_eval.expr/5>
iex> add.(1,2)
3
```


# Operators

- +, -, /, *
- div/2, rem/2
- ++, --
- <>
- ||, &&, !
- or, and
- ==, !=, <, >, <=, >=, ===, !==
- in

```elixir
iex> 1 + 1
2
iex> 1 - 1
0
iex> 1 * 2
2
iex> 1 / 2
0.5
iex> div(1,2)
0
iex> rem(1,2)
1

iex> [1, 2, 3] ++ [4,5]
[1, 2, 3, 4, 5]
iex(8)> [1, 2, 3] -- [3]
[1, 2]

iex> "Hello" <> " " <> "World" <> " !"
"Hello World !"

iex> 1.0 == 1
true
iex> 1.0 === 1
false
iex> 1.0 != 1
false
iex> 1.0 !== 1
true

iex> 1 in [1, 2, 3, 4]
true
iex> 5 in [1, 2, 3, 4]
false
```

# Pattern Matching

Some people say the concept of pattern matching is difficult to grasp by someone coming from OO world...
I think the concept of assigning is harder to grasp when the first language you learn is OO!

```ruby
2.1.5 :001 > a = 1
 => 1
2.1.5 :002 > b = 1
 => 1
2.1.5 :003 > c = 2
 => 2
2.1.5 :004 > a = c
 => 2
```

```elixir
iex> a = 1
1
iex> b = 1
1
iex> c = 2
2
iex> ^a = b
1
iex> ^a = c
** (MatchError) no match of right hand side value: 2
iex> a = c
2
iex> a
2
```

```elixir
iex> list = [1,2,3,4,5]
[1,2,3,4,5]
iex> [ h | t ] = list
[1,2,3,4,5]
iex> [ h | _ ] = list
[1,2,3,4,5]
iex> h
1
iex> [ _ | t ] = list
[1,2,3,4,5]
iex> t
[2,3,4,5]
iex> tuple = { :ok, { :name, "John" } }
:ok, {:name, "John"}}
iex> {_, {_, name}} = tuple
{:ok, {:name, "John"}}
iex> name
"John"
```

Now a code example ... lets pattern match on a MP3 file!

```elixir
defmodule Mp3Info do

  @file_name "Divider.mp3"

  def read_info(input_file \\ @file_name) do
    {:ok, mp3_file} = File.read(input_file)
    mp3_size_without_id3 = (byte_size(mp3_file) - 128)
    << _ :: binary-size(mp3_size_without_id3), id3_v1_tag_data :: binary >> = mp3_file

    << tag      :: binary-size(3),
       title    :: binary-size(30),
       artist   :: binary-size(30),
       album    :: binary-size(30),
       year     :: binary-size(4),
       comments :: binary-size(30),
       _        :: binary >> = id3_v1_tag_data

    IO.puts """
    [ID3v1 Info]
    Tag:            #{tag}
    Title:          #{title}
    Artist:         #{artist}
    Album:          #{album}
    Year:           #{year}
    Comments:       #{comments}
    """
  end

  def write_info(input_file \\ @file_name, output_file \\ "new.mp3") do
    {:ok, mp3_file} = File.read(input_file)
    tag      = "TAG"
    author   = pad("Chris Zabriskie", 30)
    title    = pad("Divider", 30)
    album   = pad("Divider", 30)
    year     = "2011"
    comments = pad("Copyright: Creative Commons", 30)

    tag_to_write = pad((tag <> author <> title <> album <> year <> comments), 128)

    mp3_size_without_id3 = (byte_size(mp3_file) - 128)
    << other_data :: binary-size(mp3_size_without_id3), _ :: binary >> = mp3_file

    File.write(output_file, (other_data <> tag_to_write))
  end


  defp pad(string, desired_size) do
    String.pad_trailing(string, desired_size)
  end

end
```

# Modules & Functions


- Defining modules
- Defining functions
- Module attributes
- Module directives
- Default values
- Guards in functions

```elixir
defmodule Demo do

  alias String, as: S
  import IO, only: [puts: 1]

  @name "john doe"

  @moduledoc """
  This is the module documentation for the Demo module.
  """

  @doc """
  This functions outputs a greeting.
  If no argument is passed it will use the default name #{@name}
  """
  def greet(name \\ @name) do
    cond do
      is_binary name ->
        # output(upcase(name))
        upcase(name) |> output_name
      true ->
        output_name(name)
    end
  end

  defp upcase(name) do
    S.upcase(name)
  end

  defp output_name(name) when is_binary name do
    # without import puts should be IO.puts
    puts "Hello #{name} !"
  end

  defp output_name(name) when is_number name do
    puts "Sorry but we don't great numbers !"
  end

end
```

# Control flow

- if, unless
- cond
- case

```elixir
iex> if true, do: IO.puts("TRUE")
TRUE
:ok
iex> unless true, do: IO.puts("FALSE")
nil
iex> value = true
true
iex> if value, do: IO.puts("TRUE")
TRUE
:ok
iex> unless value, do: IO.puts("TRUE")
nil
iex> value = false
false
iex> unless value, do: IO.puts("TRUE")
TRUE
:ok
iex> value = true
true
iex> if value do
      IO.puts("TRUE")
     end

TRUE
:ok

iex> number = 2
2
iex> cond do
      number == 0 -> "zero"
      number <= 0 -> "negative"
      number > 0 -> "positive"
    end

"positive"

iex> value = {:ok, -1 }
{:ok, -1}
iex> case value do
      {:ok, 0} -> "ok and 0"
      {:error, -1} -> "error and -1"
      {_, -1 } -> "whatever and -1"
      true -> "whatever, I don't care!"
    end

"whatever and -1"
```

# Processes and Nodes

- Creating and connecting nodes
- Sending messages between nodes
- Code running on all CPUs

```elixir
iex> c "messages.ex"
iex> {:ok, pid} = Messages.start_link
{:ok, #PID<0.61.0>}
iex> Process.register(pid, :messages)
true
iex> send :messages, {"hello", self()}
What do you mean? I'm only listening to pings and pongs!
{"hello", #PID<0.53.0>}
iex> send :messages, {"what", self()}
What do you mean? I'm only listening to pings and pongs!
{"what", #PID<0.53.0>}
iex> send :messages, {"ping", self()}
So ping to you too!
{"ping", #PID<0.53.0>}
iex> send :messages, {"pong", self()}
So pong to you too!
{"pong", #PID<0.53.0>}
iex> send :messages, {"pong", self()}
So pong to you too!
{"pong", #PID<0.53.0>}
iex> send :messages, {"ping", self()}
So ping to you too!
{"ping", #PID<0.53.0>}
iex> send :messages, {"bye", self()}
What do you mean? I'm only listening to pings and pongs!
{"bye", #PID<0.53.0>}
iex> flush
"what?"
"what?"
"ping"
"pong"
"pong"
"ping"
"what?"
:ok
```

Run without smp:
```
iex --erl "+S 1"
```

```elixir
iex(1)> c "multiple_calculations.ex" [MultipleCalculations]
iex(2)> MultipleCalculations.start
:ok
Sum of the squares of all odd numbers divisible by 13 between 1
and 10000000 is 12820474358991153855
time: 4758 ms
Sum of the squares of all odd numbers divisible by 13 between 1
and 20000000 is 102564194871779230759
time: 8286 ms
Sum of the squares of all odd numbers divisible by 13 between 1
and 30000000 is 346153707692261153854
time: 10848 ms
Sum of the squares of all odd numbers divisible by 13 between 1
and 40000000 is 820513558974493846150
time: 13347 ms
```

```elixir
```

# Tasks and Agents

- Tasks
- Agents

The Task module in Elixir provides a simple abstraction for the use of processes with the purpose of performing one action during their life cycle. Normally, tasks are used when there is no need to perform communication between processes, and are a very powerful tool to help parallelize computation.

```elixir
defmodule Geolocator do
  @ip_list [ "216.58.209.227", "199.16.156.198", "213.13.146.138",
             "114.134.80.162", "134.170.188.221", "216.58.210.3"]

  def concurrent(ip_list \\ @ip_list) when is_list ip_list do
    ip_list
    |> Enum.map(fn(ip)->
      Task.async(fn -> ip |> locate end)
    end)
    |> Enum.map(&Task.await/1)
  end

  def sequential(ip_list \\ @ip_list) when is_list ip_list do
    Enum.map(ip_list, fn(x) -> locate(x) end)
  end

  def locate(ip) do
    case Geolix.lookup(ip) do
      %{country: country} ->
        location = get_in(country, [:country, :names, :en])
        IO.puts "IP: #{ip}  Country: #{location}"
      _ ->
        IO.puts "Could not determine the location of IP #{ip}"
    end
  end
end

Geolocator.sequential
Geolocator.concurrent
```

The Agent module provides a basic server implementation and is a convenient way to spawn a process that needs to maintain a state. Agents in Elixir provide an intuitive API to update and retrieve the state.

```elixir
defmodule PhoneBook do

  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def insert(user, number) do
    Agent.update(@name, &Map.put(&1, user, number))
  end

  def get(user) do
    Agent.get(@name, &Map.get(&1, user))
  end

end

PhoneBook.start_link
PhoneBook.insert(:bob, "111-22-333-444")
PhoneBook.insert(:joe, "111-99-999-999")
PhoneBook.get(:joe)
```
