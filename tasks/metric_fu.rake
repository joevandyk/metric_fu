require 'rake'
namespace :metrics do
  desc "Generate all metrics reports"
  task :all do
    MetricFu::Configuration.run {}
    MetricFu.metrics.each {|metric| MetricFu.report.add(metric) }
    MetricFu.report.save_output(MetricFu.report.to_yaml,
                                MetricFu.base_directory, 
                                'report.yml')
    MetricFu.report.save_templatized_report
    if MetricFu.report.open_in_browser?
      MetricFu.report.show_in_browser(MetricFu.output_directory)
    end
  end
end
