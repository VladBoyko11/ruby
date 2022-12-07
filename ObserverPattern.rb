class Subject
  def initialize(observers = [])
    @observers = observers
  end
  def subscribe(observer)
    if @observers.include?(observer)
      puts("observer has already been subscribed")
    elsif observer.class == Observer
      @observers.push(observer)
    else
      puts("observer #{observer.class} is not an instance of Observer class")
    end
  end
  def unsubscribe(observer)
    begin
      @observers.delete(observer)
    rescue
      puts "observer has not subscribed"
    end
  end
  def notify(some_notify)
    @observers.each do |observer|
      begin
        observer.update(some_notify)
        puts " "
      rescue
        puts "it`s not a method!"
        puts " "
      end
    end
  end
end

class Observer
  def initialize(name)
    @name = name
  end
  def update(option)
    puts "observerName: #{@name} \nsomeOptions: #{option}"
  end
end

a = 10
observer1 = Observer.new('observer1')
observer2 = Observer.new('observer2')

subject = Subject.new([observer1])

subject.subscribe(observer1)
subject.subscribe(observer2)
subject.subscribe(a)
subject.notify('some update 1')
subject.unsubscribe(a)
subject.notify('some update 2')