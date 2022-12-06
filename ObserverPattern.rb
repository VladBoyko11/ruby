class Subject
  def initialize()
    @observers = []
  end
  def subscribe(observer)
    @observers.push(observer)
  end
  def unsubscribe(observer)
    begin
      @observers.delete(observer)
    rescue
      puts "observer has not subscribed"
    end
  end
  def notify(someNotify)
    @observers.each do |observer|
      begin
        observer.update(someNotify)
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

subject = Subject.new()
a = 10
observer1 = Observer.new('observer1')
observer2 = Observer.new('observer2')

subject.subscribe(observer1)
subject.subscribe(observer2)
subject.subscribe(a)
subject.notify('some update 1')
subject.unsubscribe(a)
subject.notify('some update 2')