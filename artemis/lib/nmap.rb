module Artemis

  class Nmap
    include Kratos::Bin
    attr_accessor :nmap_scripts, :anon_setting, :config, :output_location, :nmap_location, :save_scan_data, :selected_command
    NMAP_DEFAULT_PATH = '/usr/bin/nmap'

    SINGLE_SCANS = %w[basic_target_scan advanced_target_scan_t4 advanced_target_scan_t5 samba_exploit_scan fingerprint_webapp webapp_firewall_detect vulners_scripts vulscan_scripts full_scan list_vulscan list_vulscan_database list_vulners list_vulscan_database list_vulners list_nmap_scripts http_errors dns_brute_force exif_data]

    MULTI_SCANS = %w[basic_network_scan]

    def initialize(nmap_location: nil, output_location: nil, save_scan_data: nil)
      @config = Configuration.new

      @nmap_location =
          if nmap_location.nil?
            @confit.data.fetch(:nmap_location)
          else
            nmap_location
          end

      @output_location =
          if output_location.nil?
            @confit.data.fetch(:nmap_output_location)
          else
            output_location
          end

      @save_scan_data =
          if save_scan_data.nil?
            @confit.data.fetch(:save_nmap_scans)
          else
            save_scan_data
          end
    end

    def basic_network_scan(target)
      selected_command = "-sP #{target}"
    end

    def basic_target_scan(target)
      selected_command = "-p 1-65535 -sV -sS -T4 #{target}"
    end

    def advanced_target_scan_t4(target)
      selected_command = "-v -p 1-65535 -sV -O -sS -T4 #{target}"
    end

    def advanced_target_scan_t5(target)
      selected_command = "-v -p 1-65535 -sV -O -sS -T5 #{target}"
    end

    def samba_exploit_scan(target)
      selected_command = "--script-args=unsafe=1 --script smb-check-vulns.nse -p 445 #{target}"
    end

    # TODO: This is not implemented (extra method arg: script)
    def script_scan(target, script)
      script = File.basename script, '.nse' if script.end_with? '.nse'
      selected_command = "-p80,443 --script #{script} #{target}"
    end

    def fingerprint_webapp(target)
      selected_command = "-p80,443 --script http-waf-fingerprint #{target}"
    end

    def webapp_firewall_detect(target)
      selected_command = "-p80,443 --script http-waf-detect --script-args='http-waf-detect.aggro,http-waf-detect.detectBodyChanges' #{target}"
    end

    def vulners_scripts(target)
      selected_command = "--script nmap-vulners -sV  #{target}"
    end

    def vulscan_scripts(target, database = nil)
      if database.nil?
        selected_command = "--script vulscan -sV  #{target}"
      else
        database += '.csv' unless database.end_with? '.csv'
        selected_command = "--script-vulscan --script-args vulscandb=#{database} -sV #{target}"
      end
    end

    def full_scan(target)
      target += '.csv' unless target.end_with? '.csv'
      selected_command = "--script nmap-vulners,vulscan -v --script-args vulscandb=scipvuldb.csv -sV ${target}"
    end

    def list_vulscan(location = nmap_script)
      location = File.join(nmap_scripts, 'vulscan')
      command "ls -lra #{location} | grep .nse"
    end

    def list_vulscan_database
      location = File.join(nmap_scripts, 'vulscan')
      command "ls -lra #{location} | grep .csv"
    end

    def list_vulners
      location = File.join(nmap_scripts, 'vulners')
      command "ls -lra #{location} | grep .nse"
    end

    def list_nmap_scripts
      Dir.glob "*.nse", File.nmap_scripts
    end

    def script_info(script)
      selected_command = "--script-help='#{script}'"
    end

    def http_errors(target)
      selected_command = "-p80,443 --script http-errors #{target}"
    end

    def dns_brute_force(target)
      selected_command = "-p80,443 --script dns-brute #{target}"
      #   nmap -p80,443 --script dns-brute --script-args dns-brute.threads=25,dns-brute.hostlist=/root/Desktop/custom-subdomain-wordlist.txt targetWebsite.com
    end

    def exif_data(target)
      selected_command = "-p80,443 --script http-exif-spider #{target}"
    end


    SCAN_DESCRIPTION = {
        "webapp TARGET": "Web-Application Fingerprint",
        "webapp_firewall_detect TARGET": "Web-Application Firewall Detection",
        "script_scan TARGET SCRIPT": "Scan using a specified nmap script",
        "list_vulscan": "List VulScan Scripts",
        "list_vulscan_database": "List VulScan Databases",
        "list_vulners": "List Vulners Scripts",
        "list_nmap_scripts": "List Nmap Scripts",
        "vulners_scripts TARGET": "Vulners Scan",
        "vulscan TARGET DATABASE=nil": "Vulscan scan all databases (optional scan a specified vulscan database)",
        "full_scan TARGET": "Web-Application Full Scan",
        "http_errors TARGET": "HTTP-Errors Scan",
        "dns_brute_force TARGET": "DNS Brute Force Scan",
        "exif_data TARGET": "EXIF Photo Data Scan"}

    def preview?
      nmap selected_command, query_only: true
    end

    def execute!
      nmap selected_command
    end

    private

    def nmap(cmd, query_only: false)

      nmap_command =
          if save_scan_data
            "nmap #{cmd}"
          else
            time = Time.now.to_i
            file = File.join(output_location, time, ".xml")
            "nmap -oX #{file} #{cmd}"
          end

      if query_only
        nmap_command
      else
        command nmap_command
      end

    end

  end

end