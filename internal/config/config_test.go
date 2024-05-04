package config

import (
	"testing"
)

func setupEnvs(t *testing.T, envs map[string]string) {
	t.Helper()
	for key, value := range envs {
		t.Setenv(key, value)
	}
}

func TestNewConfig(t *testing.T) {
	setupEnvs(t, map[string]string{"DATABASE_URL": "foo", "PORT": "bar", "DEBUG": "true"})

	_, err := NewConfig()
	if err != nil {
		t.Errorf("expected: %v, want: %v", err, nil)
	}
}

func TestNewConfigError(t *testing.T) {
	cases := []struct {
		name    string
		envs    map[string]string
		wantErr string
	}{
		{"DATABASE_URL", map[string]string{"PORT": "bar", "DEBUG": "true"}, "DATABASE_URL is not set"},
		{"PORT", map[string]string{"DATABASE_URL": "foo", "DEBUG": "true"}, "PORT is not set"},
	}

	for _, tt := range cases {
		t.Run(tt.name, func(t *testing.T) {
			setupEnvs(t, tt.envs)

			_, err := NewConfig()
			if err == nil {
				t.Errorf("%s: expected: %v, wantErr: %v", tt.name, nil, tt.wantErr)
			}
		})
	}
}

func TestDatabaseURL(t *testing.T) {
	want := "root:root@tcp(localhost:33306)/main_db?charset=utf8mb4&parseTime=true"

	setupEnvs(t, map[string]string{"DATABASE_URL": want, "PORT": "bar", "DEBUG": "true"})

	cfg, _ := NewConfig()
	got := cfg.DatabaseURL()
	if got != want {
		t.Errorf("expected: %v, want: %v", got, want)
	}
}

func TestPort(t *testing.T) {
	want := "8080"

	setupEnvs(t, map[string]string{"DATABASE_URL": "foo", "PORT": want, "DEBUG": "true"})

	cfg, _ := NewConfig()
	got := cfg.Port()
	if got != want {
		t.Errorf("expected: %v, want: %v", got, want)
	}
}

func TestDebug(t *testing.T) {
	cases := []struct {
		name string
		envs map[string]string
		want bool
	}{
		{"DEBUG=true", map[string]string{"DATABASE_URL": "foo", "PORT": "bar", "DEBUG": "true"}, true},
		{"DEBUG=false", map[string]string{"DATABASE_URL": "foo", "PORT": "bar", "DEBUG": "false"}, false},
		{"DEBUG not set", map[string]string{"DATABASE_URL": "foo", "PORT": "bar"}, false},
		{"DEBUG is an invalid value", map[string]string{"DATABASE_URL": "foo", "PORT": "bar", "DEBUG": "hoge"}, false},
	}

	for _, tt := range cases {
		t.Run(tt.name, func(t *testing.T) {
			setupEnvs(t, tt.envs)

			cfg, _ := NewConfig()
			got := cfg.Debug()
			if got != tt.want {
				t.Errorf("%s: expected: %v, want: %v", tt.name, got, tt.want)
			}
		})
	}
}
